#include <stdbool.h>
#include <stdlib.h>

bool is_prime(int num) {
    if (num < 2) return false;
    for (int i = 2; i * i <= num; i++) {
        if (num % i == 0) return false;
    }
    return true;
}

int count_prime_pairs(int* primes, int primesSize, int target) {
    int count = 0;
    for (int i = 0; i < primesSize; i++) {
        for (int j = i + 1; j < primesSize; j++) {
            if (primes[i] + primes[j] == target) {
                count++;
            }
        }
    }
    return count;
}

int countPrimePairs(int* primes, int primesSize, int target) {
    return count_prime_pairs(primes, primesSize, target);
}