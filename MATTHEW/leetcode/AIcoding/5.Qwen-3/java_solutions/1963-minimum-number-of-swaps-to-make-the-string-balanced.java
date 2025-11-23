public class Solution {
    public int minSwaps(String s) {
        int open = 0;
        int close = 0;
        for (char c : s.toCharArray()) {
            if (c == '[') {
                open++;
            } else {
                close++;
            }
            if (close > open) {
                open++;
            }
        }
        return (open - close + 1) / 2;
    }
}