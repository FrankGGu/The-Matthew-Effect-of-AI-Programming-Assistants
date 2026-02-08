int numPrimeArrangements(int n) {
    if (n <= 1) return 1;

    int primes = 0;
    for (int i = 2; i <= n; i++) {
        int isPrime = 1;
        for (int j = 2; j * j <= i; j++) {
            if (i % j == 0) {
                isPrime = 0;
                break;
            }
        }
        if (isPrime) primes++;
    }

    int nonPrimes = n - primes;
    long result = 1;
    int mod = 1000000007;

    for (int i = 1; i <= primes; i++) {
        result = (result * i) % mod;
    }

    for (int i = 1; i <= nonPrimes; i++) {
        result = (result * i) % mod;
    }

    return (int)result;
}