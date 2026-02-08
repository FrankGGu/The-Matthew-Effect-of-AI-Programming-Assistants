class Solution {
    public int divide(int dividend, int divisor) {
        if (dividend == Integer.MIN_VALUE && divisor == -1) {
            return Integer.MAX_VALUE;
        }

        boolean isNegative = (dividend < 0) ^ (divisor < 0);

        long ldividend = Math.abs((long) dividend);
        long ldivisor = Math.abs((long) divisor);

        int result = 0;

        while (ldividend >= ldivisor) {
            long tempDivisor = ldivisor;
            long multiple = 1;
            while (ldividend >= (tempDivisor << 1)) {
                tempDivisor <<= 1;
                multiple <<= 1;
            }
            ldividend -= tempDivisor;
            result += multiple;
        }

        return isNegative ? -result : result;
    }
}