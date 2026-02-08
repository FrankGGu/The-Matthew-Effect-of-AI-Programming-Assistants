class Solution {
public:
    bool repeatedSubstringPattern(string s) {
        int n = s.size();
        for (int len = 1; len <= n / 2; ++len) {
            if (n % len == 0) {
                string substring = s.substr(0, len);
                string repeated = "";
                for (int j = 0; j < n / len; ++j) {
                    repeated += substring;
                }
                if (repeated == s) {
                    return true;
                }
            }
        }
        return false;
    }
};