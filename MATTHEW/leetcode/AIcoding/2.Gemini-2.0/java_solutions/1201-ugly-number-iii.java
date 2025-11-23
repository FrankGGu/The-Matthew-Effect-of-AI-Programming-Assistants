class Solution {
    public int nthUglyNumber(int n, int a, int b, int c) {
        long low = 1, high = 2 * (long) Math.pow(10, 9);
        long ab = lcm(a, b);
        long ac = lcm(a, c);
        long bc = lcm(b, c);
        long abc = lcm(a, bc);

        while (low < high) {
            long mid = low + (high - low) / 2;
            long count = mid / a + mid / b + mid / c - mid / ab - mid / ac - mid / bc + mid / abc;
            if (count < n) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return (int) low;
    }

    private long gcd(long a, long b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }

    private long lcm(long a, long b) {
        return a * b / gcd(a, b);
    }
}