import java.util.Arrays;

class Solution {
    private int MOD = 1_000_000_007;
    private int[][][] memo;
    private String S;
    private int MIN_SUM, MAX_SUM;

    public int count(String num1, String num2, int min_sum, int max_sum) {
        int ans2 = getCount(num2, min_sum, max_sum);
        String num1_minus_1 = subtractOne(num1);
        int ans1 = getCount(num1_minus_1, min_sum, max_sum);

        return (ans2 - ans1 + MOD) % MOD;
    }

    private int dp(int idx, int currentSum, boolean isTight) {
        if (currentSum > MAX_SUM) {
            return 0;
        }
        if (idx == S.length()) {
            return currentSum >= MIN_SUM ? 1 : 0;
        }

        if (memo[idx][currentSum][isTight ? 1 : 0] != -1) {
            return memo[idx][currentSum][isTight ? 1 : 0];
        }

        long ans = 0;
        int upperLimit = isTight ? (S.charAt(idx) - '0') : 9;

        for (int digit = 0; digit <= upperLimit; digit++) {
            ans = (ans + dp(idx + 1, currentSum + digit, isTight && (digit == upperLimit))) % MOD;
        }

        return memo[idx][currentSum][isTight ? 1 : 0] = (int) ans;
    }

    private int getCount(String s, int minSum, int maxSum) {
        if (s.equals("-1")) {
            return 0;
        }
        S = s;
        MIN_SUM = minSum;
        MAX_SUM = maxSum;

        int maxPossibleSumForS = 9 * s.length();
        memo = new int[s.length()][maxPossibleSumForS + 1][2];
        for (int i = 0; i < s.length(); i++) {
            for (int j = 0; j < maxPossibleSumForS + 1; j++) {
                Arrays.fill(memo[i][j], -1);
            }
        }
        return dp(0, 0, true);
    }

    private String subtractOne(String n) {
        char[] chars = n.toCharArray();
        int i = chars.length - 1;
        while (i >= 0 && chars[i] == '0') {
            chars[i] = '9';
            i--;
        }
        if (i < 0) {
            return "-1";
        }
        chars[i]--;
        if (chars[0] == '0' && chars.length > 1) {
            return new String(chars, 1, chars.length - 1);
        }
        return new String(chars);
    }
}