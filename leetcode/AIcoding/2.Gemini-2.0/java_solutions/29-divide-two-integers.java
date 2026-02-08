class Solution {
    public int divide(int dividend, int divisor) {
        if (dividend == Integer.MIN_VALUE && divisor == -1) {
            return Integer.MAX_VALUE;
        }

        boolean sign = (dividend > 0) == (divisor > 0);

        long dvd = Math.abs((long) dividend);
        long dvs = Math.abs((long) divisor);

        long quotient = 0;
        while (dvd >= dvs) {
            long temp = dvs;
            long multiple = 1;
            while (dvd >= (temp << 1)) {
                if (temp > Integer.MAX_VALUE >> 1) break;
                temp <<= 1;
                multiple <<= 1;
            }
            dvd -= temp;
            quotient += multiple;
        }

        if (!sign) {
            quotient = -quotient;
        }

        return (int) quotient;
    }
}