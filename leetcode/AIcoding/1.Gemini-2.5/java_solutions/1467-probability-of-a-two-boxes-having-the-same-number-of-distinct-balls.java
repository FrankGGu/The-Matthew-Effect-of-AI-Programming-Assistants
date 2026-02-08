class Solution {
    private int[] balls;
    private int numColors;
    private int halfTotalBalls;
    private long[][] combinations;
    private long totalWays;
    private long favorableWays;

    public double probabilityOfSameDistinct(int[] balls) {
        this.balls = balls;
        this.numColors = balls.length;

        int sumBalls = 0;
        for (int b : balls) {
            sumBalls += b;
        }
        this.halfTotalBalls = sumBalls / 2;

        combinations = new long[sumBalls + 1][sumBalls + 1];
        for (int i = 0; i <= sumBalls; i++) {
            combinations[i][0] = 1;
            for (int j = 1; j <= i; j++) {
                combinations[i][j] = combinations[i - 1][j - 1] + combinations[i - 1][j];
            }
        }

        totalWays = 0;
        favorableWays = 0;

        dfs(0, 0, 0, 0, 0, 1L);

        return (double) favorableWays / totalWays;
    }

    private void dfs(int colorIndex, int currentBalls1, int currentBalls2, int distinct1, int distinct2, long currentWays) {
        if (colorIndex == numColors) {
            if (currentBalls1 == halfTotalBalls && currentBalls2 == halfTotalBalls) {
                totalWays += currentWays;
                if (distinct1 == distinct2) {
                    favorableWays += currentWays;
                }
            }
            return;
        }

        for (int i = 0; i <= balls[colorIndex]; i++) {
            int b1_i = i;
            int b2_i = balls[colorIndex] - i;

            if (currentBalls1 + b1_i > halfTotalBalls || currentBalls2 + b2_i > halfTotalBalls) {
                continue;
            }

            int newDistinct1 = distinct1 + (b1_i > 0 ? 1 : 0);
            int newDistinct2 = distinct2 + (b2_i > 0 ? 1 : 0);

            long waysForThisColor = combinations[balls[colorIndex]][b1_i];

            dfs(colorIndex + 1,
                currentBalls1 + b1_i,
                currentBalls2 + b2_i,
                newDistinct1,
                newDistinct2,
                currentWays * waysForThisColor);
        }
    }
}