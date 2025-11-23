class Solution {
    public int maxTotalReward(int[] rewardValues) {
        Arrays.sort(rewardValues);
        int max = rewardValues[rewardValues.length - 1];
        boolean[] dp = new boolean[2 * max];
        dp[0] = true;

        for (int num : rewardValues) {
            for (int i = Math.min(num, max); i >= 0; i--) {
                if (dp[i] && i + num < 2 * max) {
                    dp[i + num] = true;
                }
            }
        }

        for (int i = 2 * max - 1; i >= 0; i--) {
            if (dp[i]) {
                return i;
            }
        }
        return 0;
    }
}