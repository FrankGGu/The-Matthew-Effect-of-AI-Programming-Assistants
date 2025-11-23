class Solution {
    private long gcd(long a, long b) {
        while (b != 0) {
            long temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    private long lcm(long a, long b) {
        // A and B are positive, so no need to handle a=0 or b=0 from problem constraints.
        return (a / gcd(a, b)) * b;
    }

    private long countMagical(long num, int A, int B, long commonMultiple) {
        return num / A + num / B - num / commonMultiple;
    }

    public int nthMagicalNumber(int n, int a, int b) {
        long low = 1; 
        // A safe upper bound for the Nth magical number.
        // The Nth magical number is roughly N / (1/A + 1/B - 1/LCM(A,B)).
        // In the worst case (e.g., A=40000, B=39999, N=10^9), this can be around 2 * 10^13.
        // 2 * 10^14 is a sufficiently large upper bound.
        long high = 2L * 10_000_000_000_000L; 

        long commonMultiple = lcm(a, b);

        long ans = high; 
        int MOD = 1_000_000_007;

        while (low <= high) {
            long mid = low + (high - low) / 2;

            long count = countMagical(mid, a, b, commonMultiple);

            if (count >= n) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return (int)(ans % MOD);
    }
}