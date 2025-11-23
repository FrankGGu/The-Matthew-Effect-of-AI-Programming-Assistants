class Solution {
public:
    int longestSemiRepetitiveSubstring(string s) {
        int n = s.size();
        int max_len = 1;
        for (int i = 0; i < n; ++i) {
            int cnt = 0;
            for (int j = i + 1; j < n; ++j) {
                if (s[j] == s[j - 1]) {
                    cnt++;
                }
                if (cnt <= 1) {
                    max_len = max(max_len, j - i + 1);
                } else {
                    break;
                }
            }
        }
        return max_len;
    }
};