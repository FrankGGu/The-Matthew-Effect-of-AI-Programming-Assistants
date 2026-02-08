class Solution {
    public String makeSmallestPalindrome(String s) {
        char[] chars = s.toCharArray();
        int left = 0;
        int right = chars.length - 1;

        while (left < right) {
            if (chars[left] != chars[right]) {
                if (chars[left] < chars[right]) {
                    chars[right] = chars[left];
                } else {
                    chars[left] = chars[right];
                }
            }
            left++;
            right--;
        }

        return new String(chars);
    }
}