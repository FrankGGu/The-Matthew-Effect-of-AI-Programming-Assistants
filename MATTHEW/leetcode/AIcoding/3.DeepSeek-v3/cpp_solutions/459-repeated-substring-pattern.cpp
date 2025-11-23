class Solution {
public:
    bool repeatedSubstringPattern(string s) {
        int n = s.size();
        for (int l = 1; l <= n / 2; ++l) {
            if (n % l != 0) continue;
            string pattern = s.substr(0, l);
            bool match = true;
            for (int i = l; i < n; i += l) {
                if (s.substr(i, l) != pattern) {
                    match = false;
                    break;
                }
            }
            if (match) return true;
        }
        return false;
    }
};