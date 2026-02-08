class Solution {
    public int maxTotalReward(int[] rewardValues) {
        Arrays.sort(rewardValues);
        int max = 0;
        boolean[] dp = new boolean[40001];
        dp[0] = true;
        for (int num : rewardValues) {
            for (int i = Math.min(max, num - 1); i >= 0; i--) {
                if (dp[i]) {
                    dp[i + num] = true;
                    if (i + num > max) {
                        max = i + num;
                    }
                }
            }
        }
        return max;
    }
}