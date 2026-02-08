#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int is_prime(int n) {
    if (n < 2) return 0;
    for (int i = 2; i <= sqrt(n); i++) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int* get_primes(int max) {
    int* primes = (int*)malloc(sizeof(int) * (max + 1));
    int count = 0;
    for (int i = 2; i <= max; i++) {
        if (is_prime(i)) {
            primes[count++] = i;
        }
    }
    return primes;
}

bool canBeSubtracted(int* nums, int numsSize) {
    int max_num = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_num) {
            max_num = nums[i];
        }
    }

    int* primes = get_primes(max_num);
    int prime_count = 0;
    while (primes[prime_count] != 0) {
        prime_count++;
    }

    for (int i = 0; i < numsSize - 1; i++) {
        int diff = nums[i] - nums[i + 1];
        int found = 0;
        for (int j = 0; j < prime_count; j++) {
            if (primes[j] == diff) {
                found = 1;
                break;
            }
        }
        if (!found) return false;
    }
    return true;
}

bool solve(int* nums, int numsSize) {
    return canBeSubtracted(nums, numsSize);
}