#include <stdbool.h>
#include <string.h>

#define MAX_VAL 101

bool isPrime[MAX_VAL];
bool sieve_initialized = false;

void init_sieve() {
    if (sieve_initialized) {
        return;
    }
    memset(isPrime, true, sizeof(isPrime));
    isPrime[0] = false;
    isPrime[1] = false;
    for (int p = 2; p * p < MAX_VAL; p++) {
        if (isPrime[p]) {
            for (int i = p * p; i < MAX_VAL; i += p)
                isPrime[i] = false;
        }
    }
    sieve_initialized = true;
}

int maximumPrimeDifference(int* nums, int numsSize) {
    init_sieve();

    int firstPrimeIdx = -1;
    int lastPrimeIdx = -1;

    for (int i = 0; i < numsSize; i++) {
        if (isPrime[nums[i]]) {
            if (firstPrimeIdx == -1) {
                firstPrimeIdx = i;
            }
            lastPrimeIdx = i;
        }
    }

    return lastPrimeIdx - firstPrimeIdx;
}