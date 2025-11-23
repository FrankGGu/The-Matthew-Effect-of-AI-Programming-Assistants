class Solution {
public:
    int longestSubsequence(string s, int k) {
        int n = s.size();
        int maxLength = 0;
        long long currentNum = 0;
        for (int i = 0; i < n; ++i) {
            if (s[i] == '1') {
                currentNum = (currentNum << 1) | 1;
            } else {
                if ((currentNum << 1) <= k) {
                    currentNum <<= 1;
                    maxLength++;
                }
            }
            if (currentNum <= k) {
                maxLength++;
            }
        }
        return maxLength;
    }
};