public class Solution {
    public int maxProduct(String s) {
        int n = s.length();
        boolean[][] isPalindrome = new boolean[n][n];

        for (int i = 0; i < n; i++) {
            isPalindrome[i][i] = true;
        }

        for (int length = 2; length <= n; length++) {
            for (int i = 0; i <= n - length; i++) {
                int j = i + length - 1;
                if (s.charAt(i) == s.charAt(j)) {
                    if (length == 2) {
                        isPalindrome[i][j] = true;
                    } else {
                        isPalindrome[i][j] = isPalindrome[i + 1][j - 1];
                    }
                } else {
                    isPalindrome[i][j] = false;
                }
            }
        }

        int maxProduct = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (isPalindrome[i][j]) {
                    int len1 = j - i + 1;
                    for (int k = 0; k < n; k++) {
                        for (int l = k; l < n; l++) {
                            if (isPalindrome[k][l] && (k > j || l < i)) {
                                int len2 = l - k + 1;
                                maxProduct = Math.max(maxProduct, len1 * len2);
                            }
                        }
                    }
                }
            }
        }

        return maxProduct;
    }
}