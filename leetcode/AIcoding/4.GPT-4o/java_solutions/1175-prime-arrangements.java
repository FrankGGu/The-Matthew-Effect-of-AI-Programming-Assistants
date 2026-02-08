class Solution {
    public int numPrimeArrangements(int n) {
        int mod = 1000000007;
        int primeCount = 0;

        for (int i = 2; i <= n; i++) {
            if (isPrime(i)) {
                primeCount++;
            }
        }

        long result = factorial(primeCount, mod) * factorial(n - primeCount, mod) % mod;
        return (int) result;
    }

    private boolean isPrime(int num) {
        if (num < 2) return false;
        for (int i = 2; i * i <= num; i++) {
            if (num % i == 0) return false;
        }
        return true;
    }

    private long factorial(int x, int mod) {
        long result = 1;
        for (int i = 1; i <= x; i++) {
            result = (result * i) % mod;
        }
        return result;
    }
}