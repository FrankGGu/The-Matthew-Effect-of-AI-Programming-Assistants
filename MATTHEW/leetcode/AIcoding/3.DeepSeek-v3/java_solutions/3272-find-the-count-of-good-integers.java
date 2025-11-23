class Solution {
    private static final int MOD = 1000000007;
    private String s;
    private int minSum;
    private int maxSum;
    private int[][][] memo;

    public int count(String num1, String num2, int min_sum, int max_sum) {
        this.minSum = min_sum;
        this.maxSum = max_sum;
        long res1 = solve(num1);
        long res2 = solve(num2);
        int sum = digitSum(num1);
        if (sum >= min_sum && sum <= max_sum) {
            res1--;
        }
        return (int) ((res2 - res1 + MOD) % MOD);
    }

    private long solve(String num) {
        this.s = num;
        int n = num.length();
        memo = new int[n][9 * n + 1][2];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= 9 * n; j++) {
                Arrays.fill(memo[i][j], -1);
            }
        }
        return dfs(0, 0, true);
    }

    private int digitSum(String num) {
        int sum = 0;
        for (char c : num.toCharArray()) {
            sum += c - '0';
        }
        return sum;
    }

    private int dfs(int pos, int sum, boolean isTight) {
        if (pos == s.length()) {
            return sum >= minSum && sum <= maxSum ? 1 : 0;
        }
        if (memo[pos][sum][isTight ? 1 : 0] != -1) {
            return memo[pos][sum][isTight ? 1 : 0];
        }
        int limit = isTight ? s.charAt(pos) - '0' : 9;
        int res = 0;
        for (int d = 0; d <= limit; d++) {
            boolean newIsTight = isTight && (d == limit);
            int newSum = sum + d;
            res = (res + dfs(pos + 1, newSum, newIsTight)) % MOD;
        }
        memo[pos][sum][isTight ? 1 : 0] = res;
        return res;
    }
}