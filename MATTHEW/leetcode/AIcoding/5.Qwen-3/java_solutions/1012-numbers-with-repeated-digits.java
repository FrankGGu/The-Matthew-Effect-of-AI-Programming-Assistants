public class Solution {
    public int numDupDigitsIntegers(int n) {
        String s = String.valueOf(n);
        int len = s.length();
        int[] dp = new int[len + 1];
        dp[0] = 0;
        dp[1] = 10;
        for (int i = 2; i <= len; i++) {
            dp[i] = dp[i - 1] * (10 - i + 1);
        }
        int res = 0;
        for (int i = 1; i < len; i++) {
            res += dp[i];
        }
        boolean[] used = new boolean[10];
        for (int i = 0; i < len; i++) {
            int digit = s.charAt(i) - '0';
            for (int j = 0; j < digit; j++) {
                if (!used[j]) {
                    res += dp[len - i - 1];
                }
            }
            if (used[digit]) {
                break;
            }
            used[digit] = true;
            if (i == len - 1) {
                res++;
            }
        }
        return res;
    }
}