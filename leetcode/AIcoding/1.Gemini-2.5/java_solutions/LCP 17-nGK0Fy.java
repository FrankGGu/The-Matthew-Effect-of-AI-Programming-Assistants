class Solution {
    public int calculate(String s) {
        int x = 1;
        for (char c : s.toCharArray()) {
            if (c == 'A') {
                x = 2 * x;
            } else if (c == 'B') {
                x = x + 1;
            }
        }
        return x;
    }
}