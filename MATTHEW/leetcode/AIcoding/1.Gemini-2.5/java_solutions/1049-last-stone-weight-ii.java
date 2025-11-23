class Solution {
    public int lastStoneWeightII(int[] stones) {
        int sum = 0;
        for (int stone : stones) {
            sum += stone;
        }

        int target = sum / 2;
        boolean[] dp = new boolean[target + 1];
        dp[0] = true;

        for (int stone : stones) {
            for (int j = target; j >= stone; j--) {
                dp[j] = dp[j] || dp[j - stone];
            }
        }

        int maxS1 = 0;
        for (int j = target; j >= 0; j--) {
            if (dp[j]) {
                maxS1 = j;
                break;
            }
        }

        return sum - 2 * maxS1;
    }
}