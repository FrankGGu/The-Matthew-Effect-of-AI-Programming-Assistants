public class Solution {
    public int countSpecialNumbers() {
        return count(1000000000);
    }

    private int count(int n) {
        String s = String.valueOf(n);
        int m = s.length();
        int[][] dp = new int[m][2];
        for (int i = 0; i < m; i++) {
            dp[i][0] = 1;
            dp[i][1] = 0;
        }
        for (int i = 1; i < m; i++) {
            dp[i][0] = dp[i - 1][0] * 9;
            dp[i][1] = dp[i - 1][1] * 9 + dp[i - 1][0];
        }
        boolean[] used = new boolean[10];
        int res = 0;
        for (int i = 0; i < m; i++) {
            int digit = s.charAt(i) - '0';
            for (int j = 0; j < digit; j++) {
                if (used[j]) continue;
                if (i == 0) {
                    res += dp[m - 1][1];
                } else {
                    res += dp[m - i - 1][0];
                }
            }
            if (used[digit]) break;
            used[digit] = true;
            if (i == m - 1) res++;
        }
        return res;
    }
}