class Solution {
    public int coinChange(int[] coins, int amount) {
        if (amount < 0) {
            return -1;
        }
        if (amount == 0) {
            return 0;
        }

        int[] dp = new int[amount + 1];
        // Initialize dp array with a value indicating "infinity"
        // amount + 1 is a good choice because the maximum number of coins
        // needed would be 'amount' (if all coins are 1), so amount + 1
        // is effectively infinity for this problem.
        for (int i = 1; i <= amount; i++) {
            dp[i] = amount + 1;
        }
        dp[0] = 0;

        for (int i = 1; i <= amount; i++) {
            for (int coin : coins) {
                if (i - coin >= 0) {
                    dp[i] = Math.min(dp[i], dp[i - coin] + 1);
                }
            }
        }

        return dp[amount] > amount ? -1 : dp[amount];
    }
}