public class Solution {
    public int divide(int dividend, int divisor) {
        if (dividend == Integer.MIN_VALUE && divisor == -1) {
            return Integer.MAX_VALUE;
        }
        int sign = ((dividend < 0) ^ (divisor < 0)) ? -1 : 1;
        long a = Math.abs((long) dividend);
        long b = Math.abs((long) divisor);
        int result = 0;
        while (a >= b) {
            int temp = 1;
            long sum = b;
            while (sum <= a) {
                sum <<= 1;
                temp <<= 1;
            }
            a -= sum >> 1;
            result += temp >> 1;
        }
        return sign == 1 ? result : -result;
    }
}