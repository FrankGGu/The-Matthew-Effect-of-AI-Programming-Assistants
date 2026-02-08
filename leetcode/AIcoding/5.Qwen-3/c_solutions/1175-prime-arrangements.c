#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int isPrime(int n) {
    if (n <= 1) return 0;
    if (n == 2) return 1;
    if (n % 2 == 0) return 0;
    int sqrt_n = (int)sqrt(n);
    for (int i = 3; i <= sqrt_n; i += 2) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int countPrimes(int n) {
    int count = 0;
    for (int i = 2; i <= n; i++) {
        if (isPrime(i)) count++;
    }
    return count;
}

int numPrimeArrangements(int n) {
    int primeCount = countPrimes(n);
    int nonPrimeCount = n - primeCount;

    long long result = 1;
    for (int i = 1; i <= primeCount; i++) {
        result *= i;
    }
    for (int i = 1; i <= nonPrimeCount; i++) {
        result *= i;
    }
    return (int)result;
}