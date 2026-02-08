class Solution {
    public int minimumBeautifulSubstrings(String s) {
        int n = s.length();
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j < i; j++) {
                if (dp[j] != Integer.MAX_VALUE && isValid(s.substring(j, i))) {
                    dp[i] = Math.min(dp[i], dp[j] + 1);
                }
            }
        }

        return dp[n] == Integer.MAX_VALUE ? -1 : dp[n];
    }

    private boolean isValid(String s) {
        if (s.charAt(0) == '0') return false;
        int num = Integer.parseInt(s, 2);
        return num == 1 || (num > 0 && (num % 5 == 0) && isPowerOfFive(num));
    }

    private boolean isPowerOfFive(int num) {
        while (num % 5 == 0) {
            num /= 5;
        }
        return num == 1;
    }
}