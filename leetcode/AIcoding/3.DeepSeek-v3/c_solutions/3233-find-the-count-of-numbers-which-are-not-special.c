#include <math.h>

int countNonSpecialNumbers(int left, int right) {
    int limit = sqrt(right);
    int max_prime = limit + 1;
    int primes[max_prime + 1];
    for (int i = 0; i <= max_prime; i++) {
        primes[i] = 1;
    }
    primes[0] = primes[1] = 0;
    for (int i = 2; i * i <= max_prime; i++) {
        if (primes[i]) {
            for (int j = i * i; j <= max_prime; j += i) {
                primes[j] = 0;
            }
        }
    }

    int count = 0;
    for (int x = left; x <= right; x++) {
        int factors = 0;
        for (int i = 1; i * i <= x; i++) {
            if (x % i == 0) {
                factors++;
                if (i != x / i) {
                    factors++;
                }
            }
        }
        int is_special = 0;
        for (int p = 2; p <= limit; p++) {
            if (primes[p] && x % (p * p) == 0) {
                is_special = 1;
                break;
            }
        }
        if (!is_special) {
            count++;
        }
    }
    return count;
}