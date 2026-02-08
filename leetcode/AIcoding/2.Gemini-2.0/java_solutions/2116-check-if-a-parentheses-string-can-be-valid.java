class Solution {
    public boolean canBeValid(String s, String locked) {
        int n = s.length();
        if (n % 2 != 0) {
            return false;
        }

        int open = 0, close = 0, unlock = 0;
        for (int i = 0; i < n; i++) {
            if (locked.charAt(i) == '1') {
                if (s.charAt(i) == '(') {
                    open++;
                } else {
                    close++;
                }
            } else {
                unlock++;
            }

            if (close > open + unlock) {
                return false;
            }
        }

        open = 0;
        close = 0;
        unlock = 0;

        for (int i = n - 1; i >= 0; i--) {
            if (locked.charAt(i) == '1') {
                if (s.charAt(i) == '(') {
                    open++;
                } else {
                    close++;
                }
            } else {
                unlock++;
            }

            if (open > close + unlock) {
                return false;
            }
        }

        return true;
    }
}