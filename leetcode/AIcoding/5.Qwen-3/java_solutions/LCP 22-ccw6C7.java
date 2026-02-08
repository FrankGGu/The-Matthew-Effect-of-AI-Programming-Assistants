public class Solution {
    public int drawLine(int length, int w, int x1, int x2, int y) {
        int result = 0;
        for (int i = x1; i <= x2; i++) {
            int bit = (i % w) / 8;
            int shift = (w - 1 - (i % w)) % 8;
            if ((y % 2) == 0) {
                result |= (1 << shift);
            } else {
                result |= (1 << shift);
            }
        }
        return result;
    }
}