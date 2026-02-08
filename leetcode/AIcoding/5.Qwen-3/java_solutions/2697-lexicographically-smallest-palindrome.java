public class Solution {
    public String makeSmallestPalindrome(String s) {
        char[] chars = s.toCharArray();
        int left = 0;
        int right = s.length() - 1;

        while (left < right) {
            if (chars[left] != chars[right]) {
                chars[right] = chars[left];
            }
            left++;
            right--;
        }

        return new String(chars);
    }
}