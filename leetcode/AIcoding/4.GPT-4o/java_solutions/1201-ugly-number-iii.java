class Solution {
    public int nthUglyNumber(int n, int a, int b, int c) {
        long lcmAB = lcm(a, b);
        long lcmAC = lcm(a, c);
        long lcmBC = lcm(b, c);
        long lcmABC = lcm(lcmAB, c);

        long left = 1, right = (long) 2e9, answer = 0;

        while (left <= right) {
            long mid = left + (right - left) / 2;
            if (countUglyNumbers(mid, a, b, c) < n) {
                left = mid + 1;
            } else {
                answer = mid;
                right = mid - 1;
            }
        }

        return (int) answer;
    }

    private long countUglyNumbers(long x, int a, int b, int c) {
        return x / a + x / b + x / c - x / lcm(a, b) - x / lcm(a, c) - x / lcm(b, c) + x / lcm(lcm(a, b), c);
    }

    private long gcd(long x, long y) {
        while (y != 0) {
            long temp = y;
            y = x % y;
            x = temp;
        }
        return x;
    }

    private long lcm(long x, long y) {
        return x / gcd(x, y) * y;
    }
}