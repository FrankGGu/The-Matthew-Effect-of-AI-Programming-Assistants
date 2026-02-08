class Solution {
    public int minimumDamageDealtToBob(int[] aliceArrows, int bobArrows) {
        int n = aliceArrows.length;
        int[] dp = new int[1 << n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            if (dp[mask] == Integer.MAX_VALUE) continue;

            int total = 0;
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) != 0) {
                    total += aliceArrows[i] + 1;
                }
            }

            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) == 0) {
                    int newMask = mask | (1 << i);
                    int cost = Math.max(0, aliceArrows[i] - bobArrows);
                    if (total + aliceArrows[i] + 1 <= bobArrows) {
                        cost = 0;
                    }
                    if (dp[newMask] > dp[mask] + cost) {
                        dp[newMask] = dp[mask] + cost;
                    }
                }
            }
        }

        int minDamage = Integer.MAX_VALUE;
        for (int mask = 0; mask < (1 << n); mask++) {
            if (dp[mask] < minDamage) {
                minDamage = dp[mask];
            }
        }
        return minDamage;
    }
}