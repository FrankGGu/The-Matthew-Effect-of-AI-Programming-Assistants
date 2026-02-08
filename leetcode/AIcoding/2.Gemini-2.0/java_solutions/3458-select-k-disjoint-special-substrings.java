import java.util.Arrays;

class Solution {
    public int maxHappyGroups(int batchSize, int[] groups) {
        int[] cnt = new int[batchSize];
        int happy = 0;
        for (int group : groups) {
            int rem = group % batchSize;
            if (rem == 0) {
                happy++;
            } else {
                cnt[rem]++;
            }
        }

        int[][] dp = new int[1 << batchSize][batchSize];
        for (int i = 0; i < (1 << batchSize); i++) {
            Arrays.fill(dp[i], -1);
        }

        dp[0][0] = 0;

        for (int mask = 0; mask < (1 << batchSize); mask++) {
            for (int rem = 0; rem < batchSize; rem++) {
                if (dp[mask][rem] == -1) continue;
                for (int i = 1; i < batchSize; i++) {
                    if (((mask >> i) & 1) == 0 && cnt[i] > 0) {
                        int newMask = mask | (1 << i);
                        int newRem = (rem + i) % batchSize;
                        dp[newMask][newRem] = Math.max(dp[newMask][newRem], dp[mask][rem] + (newRem == 0 ? 1 : 0));
                    }
                }
            }
        }

        int maxHappy = dp[(1 << batchSize) - 1][0];
        return happy + maxHappy;
    }
}