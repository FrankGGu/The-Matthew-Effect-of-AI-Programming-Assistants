public class Solution {

import java.util.Arrays;

public class Solution {
    public int minDifficulty(int[] jobDifficulty, int d) {
        int n = jobDifficulty.length;
        if (n < d) return -1;

        int[] dp = new int[n];
        Arrays.fill(dp, Integer.MAX_VALUE);

        for (int day = 0; day < d; day++) {
            int[] nextDp = new int[n];
            Arrays.fill(nextDp, Integer.MAX_VALUE);
            int maxSoFar = Integer.MAX_VALUE;

            for (int i = day; i < n; i++) {
                maxSoFar = Math.min(maxSoFar, jobDifficulty[i]);
                if (day == 0) {
                    nextDp[i] = maxSoFar;
                } else {
                    for (int j = day - 1; j < i; j++) {
                        if (dp[j] != Integer.MAX_VALUE) {
                            nextDp[i] = Math.min(nextDp[i], dp[j] + maxSoFar);
                        }
                    }
                }
            }
            dp = nextDp;
        }

        return dp[n - 1] == Integer.MAX_VALUE ? -1 : dp[n - 1];
    }
}
}