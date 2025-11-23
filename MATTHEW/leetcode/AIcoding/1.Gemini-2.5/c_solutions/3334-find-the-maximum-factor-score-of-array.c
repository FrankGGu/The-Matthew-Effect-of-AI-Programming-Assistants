#include <stdbool.h> // Required for bool type, though not strictly used in the final code.
#include <string.h>  // Not strictly needed.

#define MAX_VAL 1000000

int spf[MAX_VAL + 1];
static bool sieve_initialized = false;

void sieve() {
    for (int i = 0; i <= MAX_VAL; i++) {
        spf[i] = i;
    }

    for (long long i = 2; i <= MAX_VAL; i++) {
        if (spf[i] == i) { // i is prime
            for (long long j = i * i; j <= MAX_VAL; j += i) {
                if (spf[j] == j) { // Only update if not already marked by a smaller prime
                    spf[j] = i;
                }
            }
        }
    }
}

int getFactorScore(int n) {
    if (n == 1) {
        return 0;
    }
    int score = 0;
    while (n > 1) {
        score++;
        n /= spf[n];
    }
    return score;
}

int findMaximumFactorScore(int* nums, int numsSize) {
    if (!sieve_initialized) {
        sieve();
        sieve_initialized = true;
    }

    int maxScore = -1;
    int maxNum = -1;

    for (int i = 0; i < numsSize; i++) {
        int currentNum = nums[i];
        int currentScore = getFactorScore(currentNum);

        if (currentScore > maxScore) {
            maxScore = currentScore;
            maxNum = currentNum;
        } else if (currentScore == maxScore) {
            if (currentNum > maxNum) {
                maxNum = currentNum;
            }
        }
    }

    return maxNum;
}