class Solution {
    public int longestPalindrome(String s) {
        int[] count = new int[128];
        for (char c : s.toCharArray()) {
            count[c]++;
        }
        int length = 0;
        boolean hasOdd = false;
        for (int c : count) {
            if (c % 2 == 0) {
                length += c;
            } else {
                length += c - 1;
                hasOdd = true;
            }
        }
        return hasOdd ? length + 1 : length;
    }
}