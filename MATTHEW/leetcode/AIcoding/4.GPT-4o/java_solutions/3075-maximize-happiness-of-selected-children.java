import java.util.Arrays;

public class Solution {
    public int maximizeHappiness(int[] happiness, int[][] groups, int k) {
        int n = happiness.length;
        int m = groups.length;
        int[][] dp = new int[n + 1][k + 1];

        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                dp[i][j] = -1;
            }
        }
        dp[0][0] = 0;

        for (int i = 0; i < m; i++) {
            int groupSize = groups[i].length;
            int groupHappiness = 0;
            for (int child : groups[i]) {
                groupHappiness += happiness[child];
            }
            for (int j = n; j >= 0; j--) {
                for (int l = k; l >= groupSize; l--) {
                    if (dp[j][l - groupSize] != -1) {
                        dp[j + groupSize][l] = Math.max(dp[j + groupSize][l], dp[j][l - groupSize] + groupHappiness);
                    }
                }
            }
        }

        int maxHappiness = 0;
        for (int j = 0; j <= n; j++) {
            maxHappiness = Math.max(maxHappiness, dp[j][k]);
        }
        return maxHappiness;
    }
}