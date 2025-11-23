class Solution {
public:
    const int MOD = 1e9 + 7;

    int numPrimeArrangements(int n) {
        int primes = countPrimes(n);
        long res = 1;
        for (int i = 1; i <= primes; ++i) {
            res = (res * i) % MOD;
        }
        for (int i = 1; i <= n - primes; ++i) {
            res = (res * i) % MOD;
        }
        return res;
    }

    int countPrimes(int n) {
        if (n <= 2) return 0;
        vector<bool> isPrime(n + 1, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= n; ++i) {
            if (isPrime[i]) {
                for (int j = i * i; j <= n; j += i) {
                    isPrime[j] = false;
                }
            }
        }
        int count = 0;
        for (int i = 2; i <= n; ++i) {
            if (isPrime[i]) {
                ++count;
            }
        }
        return count;
    }
};