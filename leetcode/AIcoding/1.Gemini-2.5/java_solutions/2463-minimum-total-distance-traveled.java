import java.util.Arrays;
import java.util.Comparator;

class Solution {

    private static class Factory {
        int pos;
        int limit;

        Factory(int pos, int limit) {
            this.pos = pos;
            this.limit = limit;
        }
    }

    public long minimumTotalDistance(int[] robot, int[][] factory) {
        Arrays.sort(robot);

        Factory[] factories = new Factory[factory.length];
        for (int i = 0; i < factory.length; i++) {
            factories[i] = new Factory(factory[i][0], factory[i][1]);
        }
        Arrays.sort(factories, Comparator.comparingInt(f -> f.pos));

        int N = robot.length;
        int M = factories.length;

        long[][] dp = new long[N + 1][M + 1];

        for (int i = 1; i <= N; i++) {
            dp[i][0] = Long.MAX_VALUE / 2;
        }

        for (int i = 1; i <= N; i++) {
            for (int j = 1; j <= M; j++) {
                dp[i][j] = dp[i][j - 1];

                long currentFactoryCost = 0;
                for (int k = 1; k <= factories[j - 1].limit && k <= i; k++) {
                    currentFactoryCost += Math.abs((long)robot[i - k] - factories[j - 1].pos);

                    if (dp[i - k][j - 1] != Long.MAX_VALUE / 2) {
                        dp[i][j] = Math.min(dp[i][j], dp[i - k][j - 1] + currentFactoryCost);
                    }
                }
            }
        }

        return dp[N][M];
    }
}