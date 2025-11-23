#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

int countPrimes(int n) {
    if (n <= 2) {
        return 0;
    }

    bool* isPrime = (bool*)malloc(sizeof(bool) * n);
    if (isPrime == NULL) {
        return 0; // Handle allocation failure
    }

    // Initialize all entries to true
    memset(isPrime, true, sizeof(bool) * n);

    isPrime[0] = false;
    isPrime[1] = false;

    for (int p = 2; p * p < n; p++) {
        // If isPrime[p] is still true, then it is a prime
        if (isPrime[p] == true) {
            // Mark all multiples of p as not prime
            for (int i = p * p; i < n; i += p)
                isPrime[i] = false;
        }
    }

    int count = 0;
    for (int i = 2; i < n; i++) {
        if (isPrime[i] == true) {
            count++;
        }
    }

    free(isPrime);
    return count;
}