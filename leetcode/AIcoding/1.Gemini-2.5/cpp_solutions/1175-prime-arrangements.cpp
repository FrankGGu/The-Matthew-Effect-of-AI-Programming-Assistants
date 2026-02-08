class Solution {
public:
    long long factorial(int k, int mod) {
        long long res = 1;
        for (int i = 1; i <= k; ++i) {
            res = (res * i) % mod;
        }
        return res;
    }

    bool isPrime(int num) {
        if (num <= 1) return false;
        for (int i = 2; i * i <= num; ++i) {
            if (num % i == 0) return false;
        }
        return true;
    }

    int numPrimeArrangements(int n) {
        int count_primes = 0;
        for (int i = 1; i <= n; ++i) {
            if (isPrime(i)) {
                count_primes++;
            }
        }

        int count_non_primes = n - count_primes;
        int MOD = 1e9 + 7;

        long long fact_primes = factorial(count_primes, MOD);
        long long fact_non_primes = factorial(count_non_primes, MOD);

        return (int)((fact_primes * fact_non_primes) % MOD);
    }
};