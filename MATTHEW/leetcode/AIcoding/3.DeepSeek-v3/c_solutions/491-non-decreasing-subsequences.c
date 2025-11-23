int** findSubsequences(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int maxSub = 1 << numsSize;
    int** result = (int**)malloc(maxSub * sizeof(int*));
    *returnColumnSizes = (int*)malloc(maxSub * sizeof(int));
    *returnSize = 0;

    for (int mask = 0; mask < maxSub; mask++) {
        int* sub = (int*)malloc(numsSize * sizeof(int));
        int subSize = 0;
        int valid = 1;
        int last = -101;

        for (int i = 0; i < numsSize; i++) {
            if (mask & (1 << i)) {
                if (subSize > 0 && nums[i] < last) {
                    valid = 0;
                    break;
                }
                sub[subSize++] = nums[i];
                last = nums[i];
            }
        }

        if (valid && subSize >= 2) {
            result[*returnSize] = (int*)malloc(subSize * sizeof(int));
            memcpy(result[*returnSize], sub, subSize * sizeof(int));
            (*returnColumnSizes)[*returnSize] = subSize;
            (*returnSize)++;
        }
        free(sub);
    }

    return result;
}