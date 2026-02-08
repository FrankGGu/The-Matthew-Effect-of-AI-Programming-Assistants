class Solution {
    public int maxProduct(String s) {
        int n = s.length();
        int[] left = new int[n];
        int[] right = new int[n];

        for (int i = 0; i < n; i++) {
            left[i] = findLongestPalindrome(s, 0, i);
        }

        for (int i = 0; i < n; i++) {
            right[i] = findLongestPalindrome(s, i, n - 1);
        }

        int maxProd = 0;
        for (int i = 0; i < n - 1; i++) {
            maxProd = Math.max(maxProd, left[i] * right[i + 1]);
        }

        return maxProd;
    }

    private int findLongestPalindrome(String s, int start, int end) {
        int maxLen = 0;
        for (int i = start; i <= end; i++) {
            for (int j = i; j <= end; j++) {
                if (isPalindrome(s, i, j)) {
                    maxLen = Math.max(maxLen, j - i + 1);
                }
            }
        }
        return maxLen;
    }

    private boolean isPalindrome(String s, int left, int right) {
        while (left < right) {
            if (s.charAt(left) != s.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
}