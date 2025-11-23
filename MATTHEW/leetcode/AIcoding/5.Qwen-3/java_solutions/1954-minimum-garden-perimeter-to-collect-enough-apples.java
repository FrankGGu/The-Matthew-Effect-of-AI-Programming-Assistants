public class Solution {
    public int minimumPerimeter(long needed) {
        long n = needed;
        long x = 1;
        while (true) {
            long apples = x * x * (x + 1) * (x + 1) / 4;
            if (apples >= n) {
                return (int) (x * 8);
            }
            x++;
        }
    }
}