public class Solution {
    public int nthMagicalNumber(int n, int k) {
        long MOD = 1000000007;
        long low = 1;
        long high = (long) n * k;
        long lcm = (long) n * k / gcd(n, k);

        while (low < high) {
            long mid = (low + high) / 2;
            long count = mid / n + mid / k - mid / lcm;
            if (count < n) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }

        return (int) (low % MOD);
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