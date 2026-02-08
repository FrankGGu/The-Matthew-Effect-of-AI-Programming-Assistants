class Solution {
public:
    int kthSmallest(vector<int>& coins, int K) {
        vector<int> dp(K + 1, 0);
        dp[0] = 1;

        for (int coin : coins) {
            for (int j = coin; j <= K; j++) {
                dp[j] += dp[j - coin];
            }
        }

        for (int i = 1; i <= K; i++) {
            if (dp[i] > 0) {
                K--;
                if (K == 0) {
                    return i;
                }
            }
        }

        return -1;
    }
};