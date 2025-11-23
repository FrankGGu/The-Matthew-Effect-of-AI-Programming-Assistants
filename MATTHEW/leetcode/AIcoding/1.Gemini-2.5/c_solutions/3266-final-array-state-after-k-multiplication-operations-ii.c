#include <stdlib.h>

#define MOD 1000000007

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD; 
    while (exp > 0) {
        if (exp % 2 == 1) {
            res = (res * base) % MOD;
        }
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

int* finalArrayState(int* nums, int numsSize, int k, int* returnSize) {
    if (nums == NULL || numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(sizeof(int) * numsSize);
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    *returnSize = numsSize;

    for (int i = 0; i < numsSize; i++) {
        long long initial_value = nums[i];
        long long multiplier_base = (long long)(i + 1); 

        long long final_multiplier = power(multiplier_base, k);

        result[i] = (int)((initial_value * final_multiplier) % MOD);
    }

    return result;
}