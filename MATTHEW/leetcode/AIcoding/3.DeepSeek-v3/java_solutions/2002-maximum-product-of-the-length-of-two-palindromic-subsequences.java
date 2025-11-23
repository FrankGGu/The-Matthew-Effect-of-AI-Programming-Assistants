class Solution {
    public int maxProduct(String s) {
        int n = s.length();
        int max = 0;
        for (int mask1 = 1; mask1 < (1 << n); mask1++) {
            if (isPalindrome(s, mask1)) {
                int len1 = Integer.bitCount(mask1);
                int remainingMask = ((1 << n) - 1) ^ mask1;
                for (int mask2 = remainingMask; mask2 > 0; mask2 = (mask2 - 1) & remainingMask) {
                    if (isPalindrome(s, mask2)) {
                        int len2 = Integer.bitCount(mask2);
                        max = Math.max(max, len1 * len2);
                    }
                }
            }
        }
        return max;
    }

    private boolean isPalindrome(String s, int mask) {
        int left = 0;
        int right = s.length() - 1;
        while (left < right) {
            while (left < right && (mask & (1 << left)) == 0) {
                left++;
            }
            while (left < right && (mask & (1 << right)) == 0) {
                right--;
            }
            if (s.charAt(left) != s.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
}