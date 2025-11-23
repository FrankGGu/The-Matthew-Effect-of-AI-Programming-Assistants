public class Solution {

import java.util.*;

public class Solution {
    public int[] maximumPoints(int[][] aliceArrows, int needPoints) {
        int n = aliceArrows.length;
        int total = 0;
        for (int i = 0; i < n; i++) {
            total += aliceArrows[i][0];
        }
        if (needPoints > total) {
            return new int[n];
        }

        int[] dp = new int[1 << n];
        Arrays.fill(dp, -1);
        dp[0] = 0;

        for (int i = 0; i < n; i++) {
            for (int mask = (1 << n) - 1; mask >= 0; mask--) {
                if (dp[mask] != -1) {
                    int newMask = mask | (1 << i);
                    dp[newMask] = Math.max(dp[newMask], dp[mask] + aliceArrows[i][0] + 1);
                }
            }
        }

        int bestMask = 0;
        for (int mask = 0; mask < (1 << n); mask++) {
            if (dp[mask] >= needPoints && dp[mask] > dp[bestMask]) {
                bestMask = mask;
            }
        }

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            if ((bestMask & (1 << i)) != 0) {
                result[i] = aliceArrows[i][0] + 1;
            } else {
                result[i] = 0;
            }
        }

        return result;
    }
}
}