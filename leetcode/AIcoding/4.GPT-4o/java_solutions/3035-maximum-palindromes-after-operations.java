class Solution {
    public int maximumPalindromes(String s, int k) {
        int n = s.length();
        boolean[] isPalindrome = new boolean[n + 1];
        int[] dp = new int[n + 1];

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                if (isPalindrome(i, j, s)) {
                    dp[j + 1] = Math.max(dp[j + 1], dp[i] + 1);
                }
            }
        }

        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = Math.max(prefix[i], dp[i + 1]);
        }

        int result = 0;
        for (int i = 0; i <= n; i++) {
            if (i + k <= n) {
                result = Math.max(result, prefix[i] + (prefix[n] - prefix[i + k]));
            }
        }

        return result;
    }

    private boolean isPalindrome(int l, int r, String s) {
        while (l < r) {
            if (s.charAt(l) != s.charAt(r)) return false;
            l++;
            r--;
        }
        return true;
    }
}