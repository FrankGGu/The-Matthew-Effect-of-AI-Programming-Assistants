#define MOD 1000000007

int factorial(int n) {
    long long result = 1;
    for (int i = 2; i <= n; i++) {
        result = (result * i) % MOD;
    }
    return (int)result;
}

int countPrimes(int n) {
    if (n < 2) return 0;
    int count = 0;
    for (int i = 2; i <= n; i++) {
        bool isPrime = 1;
        for (int j = 2; j * j <= i; j++) {
            if (i % j == 0) {
                isPrime = 0;
                break;
            }
        }
        if (isPrime) count++;
    }
    return count;
}

int numPrimeArrangements(int n) {
    int primeCount = countPrimes(n);
    return (factorial(primeCount) * factorial(n - primeCount)) % MOD;
}