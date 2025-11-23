class Solution {
public:
    string nearestPalindromic(string n) {
        int len = n.size();
        set<long long> candidates;
        candidates.insert(pow(10, len) + 1);
        candidates.insert(pow(10, len - 1) - 1);

        long long prefix = stoll(n.substr(0, (len + 1) / 2));
        for (long long i = prefix - 1; i <= prefix + 1; ++i) {
            string s = to_string(i);
            string palin = s + string(s.rbegin() + (len % 2), s.rend());
            candidates.insert(stoll(palin));
        }

        long long ans = LLONG_MAX;
        for (auto candidate : candidates) {
            if (candidate != stoll(n)) {
                if (abs(candidate - stoll(n)) < abs(ans - stoll(n)) || 
                    (abs(candidate - stoll(n)) == abs(ans - stoll(n)) && candidate < ans)) ) {
                    ans = candidate;
                }
            }
        }
        return to_string(ans);
    }
};