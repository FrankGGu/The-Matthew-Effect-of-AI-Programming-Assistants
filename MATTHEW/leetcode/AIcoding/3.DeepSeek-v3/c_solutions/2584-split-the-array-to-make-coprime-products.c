/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findValidSplit(int* nums, int numsSize, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = -1;
    result[1] = -1;

    if (numsSize == 1) {
        return result;
    }

    // Find the rightmost occurrence of each prime factor
    int max_prime = 1000;
    int* last_occurrence = (int*)calloc(max_prime + 1, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        int x = nums[i];
        // Factorize x
        for (int p = 2; p * p <= x; p++) {
            if (x % p == 0) {
                last_occurrence[p] = i;
                while (x % p == 0) {
                    x /= p;
                }
            }
        }
        if (x > 1) {
            if (x <= max_prime) {
                last_occurrence[x] = i;
            }
        }
    }

    // Find the split point
    int max_index = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        int x = nums[i];
        // Update max_index with factors of nums[i]
        for (int p = 2; p * p <= x; p++) {
            if (x % p == 0) {
                if (last_occurrence[p] > max_index) {
                    max_index = last_occurrence[p];
                }
                while (x % p == 0) {
                    x /= p;
                }
            }
        }
        if (x > 1) {
            if (x <= max_prime && last_occurrence[x] > max_index) {
                max_index = last_occurrence[x];
            }
        }

        if (i >= max_index) {
            result[0] = i;
            result[1] = i + 1;
            break;
        }
    }

    free(last_occurrence);
    return result;
}