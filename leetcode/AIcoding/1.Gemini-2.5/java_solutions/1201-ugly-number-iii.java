class Solution {
    private long gcd(long x, long y) {
        if (y == 0) {
            return x;
        }
        return gcd(y, x % y);
    }

    private long lcm(long x, long y) {
        if (x == 0 || y == 0) {
            return 0; // Should not happen with positive a,b,c
        }
        if (x == 1 || y == 1) {
            return x * y;
        }
        long commonDivisor = gcd(x, y);
        long val1 = x / commonDivisor;
        // Check for overflow before multiplication: val1 * y
        // If val1 > Long.MAX_VALUE / y, then val1 * y would overflow.
        // In this case, return Long.MAX_VALUE to signify an "effectively infinite" LCM.
        if (val1 > Long.MAX_VALUE / y) {
            return Long.MAX_VALUE;
        }
        return val1 * y;
    }

    private long countUglyNumbers(long num, int a, int b, int c) {
        long countA = num / a;
        long countB = num / b;
        long countC = num / c;

        long lcmAB = lcm(a, b);
        long countAB = (lcmAB == Long.MAX_VALUE) ? 0 : num / lcmAB;

        long lcmAC = lcm(a, c);
        long countAC = (lcmAC == Long.MAX_VALUE) ? 0 : num / lcmAC;

        long lcmBC = lcm(b, c);
        long countBC = (lcmBC == Long.MAX_VALUE) ? 0 : num / lcmBC;

        long lcmABC = lcm(lcm(a, b), c);
        long countABC = (lcmABC == Long.MAX_VALUE) ? 0 : num / lcmABC;

        return countA + countB + countC - countAB - countAC - countBC + countABC;
    }

    public int nthUglyNumber(int n, int a, int b, int c) {
        long low = 1;
        // The problem guarantees that the n-th ugly number will be in the range [1, 2 * 10^9].
        long high = 2_000_000_000L; 
        long ans = high;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            if (countUglyNumbers(mid, a, b, c) >= n) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return (int) ans;
    }
}