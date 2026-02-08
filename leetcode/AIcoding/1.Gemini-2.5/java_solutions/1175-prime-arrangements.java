class Solution {
    private static final int MOD = 1_000_000_007;

    public int numPrimeArrangements(int n) {
        int primeCount = 0;
        for (int i = 1; i <= n; i++) {
            if (isPrime(i)) {
                primeCount++;
            }
        }

        int nonPrimeCount = n - primeCount;

        long result = factorial(primeCount);
        result = (result * factorial(nonPrimeCount)) % MOD;

        return (int) result;
    }

    private boolean isPrime(int num) {
        if (num <= 1) {
            return false;
        }
        if (num == 2) {
            return true;
        }
        if (num % 2 == 0) {
            return false;
        }
        for (int i = 3; i * i <= num; i += 2) {
            if (num % i == 0) {
                return false;
            }
        }
        return true;
    }

    private long factorial(int k) {
        long res = 1;
        for (int i = 1; i <= k; i++) {
            res = (res * i) % MOD;
        }
        return res;
    }
}