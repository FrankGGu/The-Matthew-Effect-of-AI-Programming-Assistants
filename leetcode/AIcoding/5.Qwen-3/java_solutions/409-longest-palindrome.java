public class Solution {
    public int longestPalindrome(String s) {
        boolean[] odd = new boolean[256];
        int length = 0;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            odd[c] = !odd[c];
        }
        for (int i = 0; i < 256; i++) {
            if (odd[i]) {
                length += 1;
            }
        }
        return length == 0 ? 0 : length * 2 - 1;
    }
}