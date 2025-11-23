public class Solution {
    public boolean canBeValid(String s) {
        if (s.length() % 2 != 0) {
            return false;
        }
        int open = 0;
        int close = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '(') {
                open++;
            } else {
                close++;
            }
            if (close > open) {
                return false;
            }
        }
        return open == close;
    }
}