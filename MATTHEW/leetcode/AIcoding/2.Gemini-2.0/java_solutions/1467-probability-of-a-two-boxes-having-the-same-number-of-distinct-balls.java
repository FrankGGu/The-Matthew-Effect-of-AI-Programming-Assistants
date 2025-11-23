class Solution {
    private double[][][] memo;
    private int[] balls;
    private int totalBalls;

    public double getProbability(int[] balls) {
        this.balls = balls;
        this.totalBalls = 0;
        for (int ball : balls) {
            totalBalls += ball;
        }

        memo = new double[balls.length + 1][totalBalls / 2 + 1][totalBalls / 2 + 1];
        for (int i = 0; i <= balls.length; i++) {
            for (int j = 0; j <= totalBalls / 2; j++) {
                for (int k = 0; k <= totalBalls / 2; k++) {
                    memo[i][j][k] = -1.0;
                }
            }
        }

        double favorable = solve(0, 0, 0);

        double totalPossibilities = combinations(totalBalls, totalBalls / 2);

        return favorable / totalPossibilities;
    }

    private double solve(int index, int box1Count, int box1Distinct) {
        if (index == balls.length) {
            if (box1Count == totalBalls / 2) {
                return 1.0;
            } else {
                return 0.0;
            }
        }

        if (memo[index][box1Count][box1Distinct] != -1.0) {
            return memo[index][box1Count][box1Distinct];
        }

        double result = 0.0;
        for (int i = 0; i <= balls[index]; i++) {
            if (box1Count + i <= totalBalls / 2) {
                int newDistinct = box1Distinct + (i > 0 ? 1 : 0);
                result += solve(index + 1, box1Count + i, newDistinct) * combinations(balls[index], i);
            }
        }

        return memo[index][box1Count][box1Distinct] = result;
    }

    private double combinations(int n, int k) {
        if (k < 0 || k > n) {
            return 0.0;
        }
        if (k == 0 || k == n) {
            return 1.0;
        }
        if (k > n / 2) {
            k = n - k;
        }
        double res = 1.0;
        for (int i = 1; i <= k; ++i) {
            res = res * (n - i + 1) / i;
        }
        return res;
    }
}