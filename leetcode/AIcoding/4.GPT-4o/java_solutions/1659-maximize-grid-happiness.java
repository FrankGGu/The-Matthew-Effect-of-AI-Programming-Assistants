import java.util.Arrays;

public class Solution {
    public int getMaxGridHappiness(int m, int n, int introvertsCount, int extrovertsCount) {
        int[][] dp = new int[1 << (m * n)][introvertsCount + 1][extrovertsCount + 1];
        for (int[][] arr : dp) {
            for (int[] a : arr) {
                Arrays.fill(a, Integer.MIN_VALUE);
            }
        }
        dp[0][0][0] = 0;

        int[] happiness = new int[1 << (m * n)];
        for (int mask = 0; mask < (1 << (m * n)); mask++) {
            for (int introverts = 0; introverts <= introvertsCount; introverts++) {
                for (int extroverts = 0; extroverts <= extrovertsCount; extroverts++) {
                    if (dp[mask][introverts][extroverts] == Integer.MIN_VALUE) continue;
                    int currentHappiness = dp[mask][introverts][extroverts];
                    for (int i = 0; i < m; i++) {
                        for (int j = 0; j < n; j++) {
                            int idx = i * n + j;
                            if ((mask & (1 << idx)) != 0) continue;

                            int newMask = mask | (1 << idx);
                            if (introverts < introvertsCount) {
                                int newHappiness = currentHappiness + 120;
                                newHappiness += getAdjacentHappiness(mask, i, j, -1);
                                dp[newMask][introverts + 1][extroverts] = Math.max(dp[newMask][introverts + 1][extroverts], newHappiness);
                            }
                            if (extroverts < extrovertsCount) {
                                int newHappiness = currentHappiness + 40;
                                newHappiness += getAdjacentHappiness(mask, i, j, 1);
                                dp[newMask][introverts][extroverts + 1] = Math.max(dp[newMask][introverts][extroverts + 1], newHappiness);
                            }
                        }
                    }
                }
            }
        }

        int maxHappiness = 0;
        for (int introverts = 0; introverts <= introvertsCount; introverts++) {
            for (int extroverts = 0; extroverts <= extrovertsCount; extroverts++) {
                maxHappiness = Math.max(maxHappiness, dp[(1 << (m * n)) - 1][introverts][extroverts]);
            }
        }
        return maxHappiness;
    }

    private int getAdjacentHappiness(int mask, int x, int y, int type) {
        int happiness = 0;
        int[] dx = {-1, 1, 0, 0};
        int[] dy = {0, 0, -1, 1};
        for (int d = 0; d < 4; d++) {
            int nx = x + dx[d];
            int ny = y + dy[d];
            if (nx < 0 || ny < 0 || nx >= (int) Math.sqrt(mask) || ny >= (int) Math.sqrt(mask)) continue;
            int idx = nx * (int) Math.sqrt(mask) + ny;
            if ((mask & (1 << idx)) != 0) {
                if (type == -1) happiness -= 30;
                else happiness += 20;
            }
        }
        return happiness;
    }
}