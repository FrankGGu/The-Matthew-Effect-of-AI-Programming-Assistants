class Solution {
    public boolean canBeValid(String s, String locked) {
        if (s.length() % 2 != 0) return false;
        int open = 0, close = 0, n = s.length();
        for (int i = 0; i < n; i++) {
            if (locked.charAt(i) == '0' || s.charAt(i) == '(') open++;
            if (locked.charAt(i) == '0' || s.charAt(i) == ')') close++;
            if (close > open) return false;
        }
        open = 0;
        close = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (locked.charAt(i) == '0' || s.charAt(i) == ')') open++;
            if (locked.charAt(i) == '0' || s.charAt(i) == '(') close++;
            if (close > open) return false;
        }
        return true;
    }
}