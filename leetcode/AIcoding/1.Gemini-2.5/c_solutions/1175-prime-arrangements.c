#include <stdbool.h>

long long MOD = 1000000007;

bool isPrime(int num) {
    if (num <= 1) return false;
    for (int i = 2; i * i <= num; i++) {
        if (num % i == 0) return false;
    }
    return true;
}

long long factorial(int k) {
    long long res = 1;
    for (int i = 1; i <= k; i++) {
        res = (res * i) % MOD;
    }
    return res;
}

int numPrimeArrangements(int n) {
    int primes_count = 0;

    // Count prime numbers from 1 to n
    for (int i = 1; i <= n; i++) {
        if (isPrime(i)) {
            primes_count++;
        }
    }

    int non_primes_count = n - primes_count;

    // Calculate (primes_count)! % MOD
    long long fact_primes = factorial(primes_count);

    // Calculate (non_primes_count)! % MOD
    long long fact_non_primes = factorial(non_primes_count);

    // Result is (fact_primes * fact_non_primes) % MOD
    return (int)((fact_primes * fact_non_primes) % MOD);
}