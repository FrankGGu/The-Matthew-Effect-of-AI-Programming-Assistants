class Solution {
    public double soupServings(int n) {
        if (n >= 4800) {
            return 1.0;
        }
        n = (n + 24) / 25;
        double[][] memo = new double[n + 1][n + 1];
        return helper(n, n, memo);
    }

    private double helper(int a, int b, double[][] memo) {
        if (a <= 0 && b <= 0) {
            return 0.5;
        }
        if (a <= 0) {
            return 1.0;
        }
        if (b <= 0) {
            return 0.0;
        }
        if (memo[a][b] > 0) {
            return memo[a][b];
        }
        memo[a][b] = 0.25 * (helper(a - 4, b, memo) + helper(a - 3, b - 1, memo) + 
                             helper(a - 2, b - 2, memo) + helper(a - 1, b - 3, memo));
        return memo[a][b];
    }
}