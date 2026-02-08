class Solution {
public:
    int longestIdealSubstring(string s, int k) {
        vector<int> dp(128, 0);
        int maxLength = 0;

        for (char c : s) {
            int idx = c;
            int currentLength = 1;

            for (int j = max(0, idx - k); j <= min(127, idx + k); j++) {
                currentLength = max(currentLength, dp[j] + 1);
            }

            dp[idx] = currentLength;
            maxLength = max(maxLength, currentLength);
        }

        return maxLength;
    }
};