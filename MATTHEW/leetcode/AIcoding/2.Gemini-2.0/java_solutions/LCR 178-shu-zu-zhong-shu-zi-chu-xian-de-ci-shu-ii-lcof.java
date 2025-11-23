import java.util.Arrays;

class Solution {
    public int trainingPlan(int[] actions, int k, int[] rewards) {
        int n = actions.length;
        int[] dp = new int[k + 1];
        Arrays.fill(dp, Integer.MIN_VALUE);
        dp[0] = 0;

        for (int i = 0; i < n; i++) {
            int[] newDp = new int[k + 1];
            Arrays.fill(newDp, Integer.MIN_VALUE);
            for (int j = 0; j <= k; j++) {
                if (dp[j] != Integer.MIN_VALUE) {
                    newDp[j] = Math.max(newDp[j], dp[j]);
                    if (actions[i] == 0 && j < k) {
                        newDp[j + 1] = Math.max(newDp[j + 1], dp[j]);
                    } else if (actions[i] == 1) {
                        newDp[j] = Math.max(newDp[j], dp[j] + rewards[i]);
                    }
                }
            }
            dp = newDp;
        }

        int maxReward = Integer.MIN_VALUE;
        for (int i = 0; i <= k; i++) {
            maxReward = Math.max(maxReward, dp[i]);
        }

        return maxReward;
    }
}