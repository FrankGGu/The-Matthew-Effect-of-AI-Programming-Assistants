class Solution {
    public int nthMagicalNumber(int N, int A, int B) {
        int MOD = 1_000_000_007;
        int L = A / gcd(A, B) * B;
        long low = 0;
        long high = (long) 1e18;
        while (low < high) {
            long mid = low + (high - low) / 2;
            if (mid / A + mid / B - mid / L < N) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return (int) (low % MOD);
    }

    private int gcd(int a, int b) {
        return b == 0 ? a : gcd(b, a % b);
    }
}