class Solution {
    public int minLength(String s) {
        StringBuilder sb = new StringBuilder(s);
        while (true) {
            int n = sb.length();
            boolean reduced = false;
            for (int i = 0; i < n - 1; i++) {
                if ((sb.charAt(i) == 'A' && sb.charAt(i + 1) == 'B') ||
                    (sb.charAt(i) == 'C' && sb.charAt(i + 1) == 'D')) {
                    sb.delete(i, i + 2);
                    reduced = true;
                    break;
                }
            }
            if (!reduced) {
                break;
            }
        }
        return sb.length();
    }
}