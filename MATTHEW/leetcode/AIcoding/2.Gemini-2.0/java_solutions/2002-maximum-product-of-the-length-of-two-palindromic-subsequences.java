class Solution {
    public int maxProduct(String s) {
        int n = s.length();
        int[] mask = new int[1 << n];

        for (int i = 1; i < (1 << n); i++) {
            StringBuilder sb = new StringBuilder();
            for (int j = 0; j < n; j++) {
                if ((i & (1 << j)) != 0) {
                    sb.append(s.charAt(j));
                }
            }
            String sub = sb.toString();
            if (isPalindrome(sub)) {
                mask[i] = sub.length();
            }
        }

        int maxProduct = 0;
        for (int i = 1; i < (1 << n); i++) {
            for (int j = 1; j < (1 << n); j++) {
                if ((i & j) == 0) {
                    maxProduct = Math.max(maxProduct, mask[i] * mask[j]);
                }
            }
        }

        return maxProduct;
    }

    private boolean isPalindrome(String s) {
        int left = 0;
        int right = s.length() - 1;
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