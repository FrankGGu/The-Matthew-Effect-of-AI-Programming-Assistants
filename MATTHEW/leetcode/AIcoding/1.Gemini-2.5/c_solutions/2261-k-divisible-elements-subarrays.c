#include <stdlib.h>

static int compare_ull(const void* a, const void* b) {
    unsigned long long val_a = *(const unsigned long long*)a;
    unsigned long long val_b = *(const unsigned long long*)b;
    if (val_a < val_b) return -1;
    if (val_a > val_b) return 1;
    return 0;
}

int countDistinct(int* nums, int numsSize, int k, int p) {
    unsigned long long* hashes = (unsigned long long*)malloc(sizeof(unsigned long long) * numsSize * (numsSize + 1) / 2);
    int hash_count = 0;

    const unsigned long long HASH_BASE = 31; 

    for (int i = 0; i < numsSize; ++i) {
        int divisible_count = 0;
        unsigned long long current_hash = 0;
        for (int j = i; j < numsSize; ++j) {
            if (nums[j] % p == 0) {
                divisible_count++;
            }

            if (divisible_count > k) {
                break;
            }

            current_hash = current_hash * HASH_BASE + nums[j];

            hashes[hash_count++] = current_hash;
        }
    }

    if (hash_count == 0) {
        free(hashes);
        return 0;
    }

    qsort(hashes, hash_count, sizeof(unsigned long long), compare_ull);

    int distinct_count = 1;
    for (int i = 1; i < hash_count; ++i) {
        if (hashes[i] != hashes[i-1]) {
            distinct_count++;
        }
    }

    free(hashes);
    return distinct_count;
}