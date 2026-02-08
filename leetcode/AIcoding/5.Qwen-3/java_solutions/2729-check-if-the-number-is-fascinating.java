public class Solution {
    public boolean isFascinating(int n) {
        if (n < 100 || n > 999) {
            return false;
        }
        StringBuilder sb = new StringBuilder();
        sb.append(n).append(n * 2).append(n * 3);
        String s = sb.toString();
        if (s.length() != 9) {
            return false;
        }
        boolean[] seen = new boolean[10];
        for (char c : s.toCharArray()) {
            int digit = c - '0';
            if (digit == 0 || seen[digit]) {
                return false;
            }
            seen[digit] = true;
        }
        return true;
    }
}