class Solution {
public:
    int maxPower(string s) {
        int max_len = 1;
        int current_len = 1;
        for (int i = 1; i < s.size(); ++i) {
            if (s[i] == s[i-1]) {
                current_len++;
                max_len = max(max_len, current_len);
            } else {
                current_len = 1;
            }
        }
        return max_len;
    }
};