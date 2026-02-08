public class Solution {
    public int findValidPair(String s) {
        for (int i = 0; i < s.length() - 1; i++) {
            if (Math.abs(s.charAt(i) - s.charAt(i + 1)) == 1) {
                return i;
            }
        }
        return -1;
    }
}