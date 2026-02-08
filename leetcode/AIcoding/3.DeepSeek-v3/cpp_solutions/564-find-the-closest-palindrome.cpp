class Solution {
public:
    string nearestPalindromic(string n) {
        long num = stol(n);
        if (num == 1) return "0";

        vector<long> candidates;
        candidates.push_back(pow(10, n.size() - 1) - 1);
        candidates.push_back(pow(10, n.size()) + 1);

        long prefix = stol(n.substr(0, (n.size() + 1) / 2));
        for (long i = -1; i <= 1; ++i) {
            string p = to_string(prefix + i);
            string candidate = p + string(p.rbegin() + (n.size() % 2), p.rend());
            candidates.push_back(stol(candidate));
        }

        long minDiff = LONG_MAX, result = 0;
        for (long candidate : candidates) {
            if (candidate == num) continue;
            long diff = abs(candidate - num);
            if (diff < minDiff) {
                minDiff = diff;
                result = candidate;
            } else if (diff == minDiff) {
                result = min(result, candidate);
            }
        }
        return to_string(result);
    }
};