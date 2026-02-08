#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countDistinct(int* nums, int numsSize, int k, int p) {
    int count = 0;
    int seen[200001] = {0}; 
    int hash_values[200001] = {0};
    int hash_count = 0;

    for (int i = 0; i < numsSize; i++) {
        int divisible_count = 0;
        for (int j = i; j < numsSize; j++) {
            if (nums[j] % p == 0) {
                divisible_count++;
            }

            if (divisible_count > k) {
                break;
            }

            long long hash = 0;
            for (int l = i; l <= j; l++) {
                hash = hash * 31 + nums[l];
            }

            bool found = false;
            for (int m = 0; m < hash_count; m++) {
                if (hash_values[m] == hash) {
                    found = true;
                    break;
                }
            }

            if (!found) {
                count++;
                hash_values[hash_count++] = hash;
            }
        }
    }

    return count;
}