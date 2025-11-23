class Solution {
public:
    int findTheLongestBalancedSubstring(string s) {
        int max_len = 0;
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            if (s[i] == '0') {
                int zero_count = 0;
                int one_count = 0;
                int j = i;
                while (j < n && s[j] == '0') {
                    ++zero_count;
                    ++j;
                }
                while (j < n && s[j] == '1') {
                    ++one_count;
                    ++j;
                }
                int balanced_len = 2 * min(zero_count, one_count);
                if (balanced_len > max_len) {
                    max_len = balanced_len;
                }
            }
        }
        return max_len;
    }
};