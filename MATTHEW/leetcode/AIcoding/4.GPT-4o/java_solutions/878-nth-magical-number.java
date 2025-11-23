class Solution {
    public int nthMagicalNumber(int N, int A, int B) {
        long lcm = lcm(A, B);
        long mod = 1000000007;
        long left = 1, right = (long) N * Math.min(A, B);
        while (left < right) {
            long mid = left + (right - left) / 2;
            if (mid / A + mid / B - mid / lcm < N) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return (int)(left % mod);
    }

    private long gcd(long a, long b) {
        while (b != 0) {
            long temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    private long lcm(long a, long b) {
        return a / gcd(a, b) * b;
    }
}