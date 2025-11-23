public class Solution {
    public int maxProduct(String s) {
        int n = s.length();
        int maxProd = 0;
        for (int mask1 = 1; mask1 < (1 << n); mask1++) {
            if (isPalindrome(s, mask1)) {
                for (int mask2 = 1; mask2 < (1 << n); mask2++) {
                    if ((mask1 & mask2) == 0 && isPalindrome(s, mask2)) {
                        int len1 = Integer.bitCount(mask1);
                        int len2 = Integer.bitCount(mask2);
                        maxProd = Math.max(maxProd, len1 * len2);
                    }
                }
            }
        }
        return maxProd;
    }

    private boolean isPalindrome(String s, int mask) {
        int left = 0;
        int right = s.length() - 1;
        while (left < right) {
            if ((mask & (1 << left)) == 0) left++;
            else if ((mask & (1 << right)) == 0) right--;
            else if (s.charAt(left) != s.charAt(right)) return false;
            else {
                left++;
                right--;
            }
        }
        return true;
    }
}