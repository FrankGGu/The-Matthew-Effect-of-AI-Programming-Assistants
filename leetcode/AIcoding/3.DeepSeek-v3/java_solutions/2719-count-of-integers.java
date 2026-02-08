class Solution {
    private static final int MOD = 1_000_000_007;
    private String num1, num2;
    private int min_sum, max_sum;
    private Integer[][][] dp;

    public int count(String num1, String num2, int min_sum, int max_sum) {
        this.num1 = num1;
        this.num2 = num2;
        this.min_sum = min_sum;
        this.max_sum = max_sum;
        this.dp = new Integer[23][401][2];
        int total = calculate(num2) - calculate(num1) + MOD;
        total %= MOD;
        int sum = digitSum(num1);
        if (sum >= min_sum && sum <= max_sum) {
            total = (total + 1) % MOD;
        }
        return total;
    }

    private int calculate(String s) {
        dp = new Integer[23][401][2];
        return dfs(0, 0, true, s);
    }

    private int dfs(int pos, int sum, boolean tight, String s) {
        if (pos == s.length()) {
            return (sum >= min_sum && sum <= max_sum) ? 1 : 0;
        }
        if (dp[pos][sum][tight ? 1 : 0] != null) {
            return dp[pos][sum][tight ? 1 : 0];
        }
        int limit = tight ? s.charAt(pos) - '0' : 9;
        int res = 0;
        for (int d = 0; d <= limit; d++) {
            int newSum = sum + d;
            if (newSum > max_sum) continue;
            boolean newTight = tight && (d == limit);
            res = (res + dfs(pos + 1, newSum, newTight, s)) % MOD;
        }
        dp[pos][sum][tight ? 1 : 0] = res;
        return res;
    }

    private int digitSum(String s) {
        int sum = 0;
        for (char c : s.toCharArray()) {
            sum += c - '0';
        }
        return sum;
    }
}