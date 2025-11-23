class Solution {
    private static final int MOD = 1000000007;

    public int numPrimeArrangements(int n) {
        int primeCount = countPrimes(n);
        long primeArrangements = factorial(primeCount) % MOD;
        long nonPrimeArrangements = factorial(n - primeCount) % MOD;
        return (int) ((primeArrangements * nonPrimeArrangements) % MOD);
    }

    private int countPrimes(int n) {
        boolean[] isPrime = new boolean[n + 1];
        for (int i = 2; i <= n; i++) {
            isPrime[i] = true;
        }
        for (int p = 2; p * p <= n; p++) {
            if (isPrime[p]) {
                for (int i = p * p; i <= n; i += p) {
                    isPrime[i] = false;
                }
            }
        }
        int count = 0;
        for (int i = 2; i <= n; i++) {
            if (isPrime[i]) {
                count++;
            }
        }
        return count;
    }

    private long factorial(int n) {
        long result = 1;
        for (int i = 2; i <= n; i++) {
            result = (result * i) % MOD;
        }
        return result;
    }
}