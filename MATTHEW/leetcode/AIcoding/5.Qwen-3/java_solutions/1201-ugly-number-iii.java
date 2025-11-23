public class Solution {
    public int nthUglyNumber(int n, int a, int b, int c) {
        long left = 1;
        long right = (long) 2e18;

        while (left < right) {
            long mid = left + (right - left) / 2;
            long count = countUgly(mid, a, b, c);
            if (count < n) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return (int) left;
    }

    private long countUgly(long x, int a, int b, int c) {
        return x / a + x / b + x / c - x / lcm(a, b) - x / lcm(a, c) - x / lcm(b, c) + x / lcm(lcm(a, b), c);
    }

    private long lcm(long a, long b) {
        return a * b / gcd(a, b);
    }

    private long gcd(long a, long b) {
        while (b != 0) {
            long temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}