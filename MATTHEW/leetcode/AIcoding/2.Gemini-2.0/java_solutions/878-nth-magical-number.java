class Solution {
    public int nthMagicalNumber(int n, int a, int b) {
        long low = Math.min(a, b);
        long high = (long) n * Math.min(a, b);
        long lcm = (long) a * b / gcd(a, b);
        int mod = 1000000007;

        while (low < high) {
            long mid = low + (high - low) / 2;
            long count = mid / a + mid / b - mid / lcm;
            if (count < n) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }

        return (int) (low % mod);
    }

    private int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
}