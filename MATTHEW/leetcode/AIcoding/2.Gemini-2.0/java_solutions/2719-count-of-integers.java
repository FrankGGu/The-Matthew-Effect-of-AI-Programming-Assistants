class Solution {
    private static final int MOD = 1000000007;
    private String min_num, max_num;
    private int min_sum, max_sum;
    private Integer[][][] dp;

    public int count(String num1, String num2, int min_sum, int max_sum) {
        this.min_num = num1;
        this.max_num = num2;
        this.min_sum = min_sum;
        this.max_sum = max_sum;
        dp = new Integer[num2.length() + 1][max_sum + 1][2];
        return solve(0, 0, 1, num2) - solve(0, 0, 1, num1) + isValid(num1);
    }

    private int solve(int index, int sum, int tight, String num) {
        if (sum > max_sum) return 0;
        if (index == num.length()) {
            return sum >= min_sum ? 1 : 0;
        }
        if (dp[index][sum][tight] != null) return dp[index][sum][tight];

        int upper_bound = tight == 1 ? num.charAt(index) - '0' : 9;
        int ans = 0;
        for (int digit = 0; digit <= upper_bound; digit++) {
            int new_tight = tight == 1 && digit == upper_bound ? 1 : 0;
            ans = (ans + solve(index + 1, sum + digit, new_tight, num)) % MOD;
        }
        return dp[index][sum][tight] = ans;
    }

    private int isValid(String num) {
        int sum = 0;
        for (char c : num.toCharArray()) {
            sum += c - '0';
        }
        return sum >= min_sum && sum <= max_sum ? 1 : 0;
    }
}