class Solution {
    public boolean isFascinating(int n) {
        String s = String.valueOf(n) + String.valueOf(2 * n) + String.valueOf(3 * n);
        if (s.length() != 9) {
            return false;
        }
        boolean[] seen = new boolean[10];
        for (char c : s.toCharArray()) {
            if (c == '0') {
                return false;
            }
            int digit = c - '0';
            if (seen[digit]) {
                return false;
            }
            seen[digit] = true;
        }
        return true;
    }
}