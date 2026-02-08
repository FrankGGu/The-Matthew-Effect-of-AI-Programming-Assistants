class Solution {
public:
    bool splitString(string s) {
        int n = s.size();
        for (int i = 1; i < n; ++i) {
            long long first = stoll(s.substr(0, i));
            if (first == 0) continue;
            long long prev = first;
            string temp = s.substr(i);
            if (canSplit(temp, prev)) {
                return true;
            }
        }
        return false;
    }

    bool canSplit(string s, long long prev) {
        if (s.empty()) return true;
        long long next = prev - 1;
        string nextStr = to_string(next);
        if (s.find(nextStr) != 0) return false;

        string remaining = s.substr(nextStr.size());
        return canSplit(remaining, next);
    }
};