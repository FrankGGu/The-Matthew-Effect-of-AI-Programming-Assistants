public class Solution {
    public int minCut(String s) {
        int n = s.length();
        if (n <= 1) return 0;

        boolean[][] isPalindrome = new boolean[n][n];
        for (int i = 0; i < n; i++) {
            isPalindrome[i][i] = true;
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (s.charAt(i) == s.charAt(j)) {
                    isPalindrome[i][j] = len == 2 || isPalindrome[i + 1][j - 1];
                }
            }
        }

        int[] cuts = new int[n];
        for (int i = 0; i < n; i++) {
            cuts[i] = i;  // max cuts
            for (int j = 0; j <= i; j++) {
                if (isPalindrome[j][i]) {
                    cuts[i] = j == 0 ? 0 : Math.min(cuts[i], cuts[j - 1] + 1);
                }
            }
        }

        return cuts[n - 1];
    }
}