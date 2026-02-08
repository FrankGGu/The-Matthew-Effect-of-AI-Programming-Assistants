class Solution {
    public boolean checkPartitioning(String s) {
        int n = s.length();

        boolean[][] isPalindrome = new boolean[n][n];

        for (int i = 0; i < n; i++) {
            isPalindrome[i][i] = true;
        }

        for (int i = 0; i < n - 1; i++) {
            isPalindrome[i][i+1] = (s.charAt(i) == s.charAt(i+1));
        }

        for (int len = 3; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                isPalindrome[i][j] = (s.charAt(i) == s.charAt(j) && isPalindrome[i+1][j-1]);
            }
        }

        for (int i = 1; i <= n - 2; i++) {
            for (int j = i + 1; j <= n - 1; j++) {
                if (isPalindrome[0][i-1] && isPalindrome[i][j-1] && isPalindrome[j][n-1]) {
                    return true;
                }
            }
        }

        return false;
    }
}