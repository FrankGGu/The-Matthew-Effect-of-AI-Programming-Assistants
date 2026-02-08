import java.util.Arrays;

class Solution {

    private long[][][][] memo;
    private String S;
    private int N;
    private static final int MOD = 1_000_000_007;

    public int countSteppingNumbers(String low, String high) {
        long countHigh = count(high);

        long countLowMinusOne;
        if (low.equals("0")) {
            countLowMinusOne = 0;
        } else {
            countLowMinusOne = count(subtractOne(low));
        }

        long result = (countHigh - countLowMinusOne + MOD) % MOD;
        return (int) result;
    }

    private long count(String s) {
        S = s;
        N = s.length();
        memo = new long[N][11][2][2];
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < 11; j++) {
                for (int k = 0; k < 2; k++) {
                    Arrays.fill(memo[i][j][k], -1);
                }
            }
        }

        return (dfs(0, -1, false, false) + 1) % MOD;
    }

    private long dfs(int idx, int prevDigit, boolean isLess, boolean isNum) {
        if (idx == N) {
            return isNum ? 1 : 0;
        }

        if (memo[idx][prevDigit + 1][isLess ? 1 : 0][isNum ? 1 : 0] != -1) {
            return memo[idx][prevDigit + 1][isLess ? 1 : 0][isNum ? 1 : 0];
        }

        long currentCount = 0;
        int upperLimit = isLess ? 9 : (S.charAt(idx) - '0');

        for (int digit = 0; digit <= upperLimit; digit++) {
            boolean newIsLess = isLess || (digit < upperLimit);

            if (!isNum) {
                if (digit == 0) {
                    currentCount = (currentCount + dfs(idx + 1, -1, newIsLess, false)) % MOD;
                } else {
                    currentCount = (currentCount + dfs(idx + 1, digit, newIsLess, true)) % MOD;
                }
            } else {
                if (Math.abs(digit - prevDigit) == 1) {
                    currentCount = (currentCount + dfs(idx + 1, digit, newIsLess, true)) % MOD;
                }
            }
        }

        return memo[idx][prevDigit + 1][isLess ? 1 : 0][isNum ? 1 : 0] = currentCount;
    }

    private String subtractOne(String n) {
        char[] chars = n.toCharArray();
        int i = chars.length - 1;
        while (i >= 0 && chars[i] == '0') {
            chars[i] = '9';
            i--;
        }
        chars[i]--;

        if (chars[0] == '0' && chars.length > 1) {
            return new String(chars, 1, chars.length - 1);
        }
        return new String(chars);
    }
}