#include <stdbool.h>
#include <stdlib.h>

bool* prefixesDivBy5(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    bool* result = (bool*)malloc(sizeof(bool) * numsSize);
    if (result == NULL) {
        return NULL;
    }

    int current_val_mod_5 = 0;

    for (int i = 0; i < numsSize; i++) {
        current_val_mod_5 = (current_val_mod_5 * 2 + nums[i]) % 5;
        result[i] = (current_val_mod_5 == 0);
    }

    return result;
}