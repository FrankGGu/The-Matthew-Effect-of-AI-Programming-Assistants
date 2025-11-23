#include <stdbool.h>
#include <stdlib.h>

bool is_prime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return false;
    }
    return true;
}

bool primeSubOperation(int* nums, int numsSize) {
    int* primes = (int*)malloc(0);
    for (int i = 2; i <= 1000; i++) {
        if (is_prime(i)) {
            primes = (int*)realloc(primes, (sizeof(int) * (i / 2 + 1)));
            primes[i / 2] = i;
        }
    }

    for (int i = numsSize - 1; i > 0; i--) {
        int valid = false;
        for (int j = 0; primes[j] < nums[i] && j < 1000; j++) {
            if (nums[i] - primes[j] > nums[i - 1]) {
                valid = true;
                nums[i] -= primes[j];
                break;
            }
        }
        if (!valid) {
            free(primes);
            return false;
        }
    }

    free(primes);
    return true;
}