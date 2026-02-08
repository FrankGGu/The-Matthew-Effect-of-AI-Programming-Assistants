class Solution {
    public long maxProduct(String s) {
        int n = s.length();
        if (n == 0) {
            return 0;
        }

        boolean[][] isPalindrome = new boolean[n][n];

        for (int i = 0; i < n; i++) {
            isPalindrome[i][i] = true;
        }

        for (int i = 0; i < n - 1; i++) {
            if (s.charAt(i) == s.charAt(i + 1)) {
                isPalindrome[i][i + 1] = true;
            }
        }

        for (int len = 3; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (s.charAt(i) == s.charAt(j) && isPalindrome[i + 1][j - 1]) {
                    isPalindrome[i][j] = true;
                }
            }
        }

        int[] maxLenLeft = new int[n];
        int[] maxLenRight = new int[n];

        for (int k = 0; k < n; k++) {
            if (k > 0) {
                maxLenLeft[k] = maxLenLeft[k - 1];
            }
            for (int i = 0; i <= k; i++) {
                if (isPalindrome[i][k]) {
                    maxLenLeft[k] = Math.max(maxLenLeft[k], k - i + 1);
                }
            }
        }

        for (int k = n - 1; k >= 0; k--) {
            if (k < n - 1) {
                maxLenRight[k] = maxLenRight[k + 1];
            }
            for (int j = k; j < n; j++) {
                if (isPalindrome[k][j]) {
                    maxLenRight[k] = Math.max(maxLenRight[k], j - k + 1);
                }
            }
        }

        long maxProduct = 0;

        for (int k = 0; k < n - 1; k++) {
            maxProduct = Math.max(maxProduct, (long) maxLenLeft[k] * maxLenRight[k + 1]);
        }

        return maxProduct;
    }
}