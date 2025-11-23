/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* distinctDifferenceArray(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* diff = malloc(numsSize * sizeof(int));
    int prefix[51] = {0};
    int suffix[51] = {0};

    for (int i = 0; i < numsSize; i++) {
        suffix[nums[i]]++;
    }

    for (int i = 0; i < numsSize; i++) {
        prefix[nums[i]]++;
        suffix[nums[i]]--;

        int prefixCount = 0;
        int suffixCount = 0;

        for (int j = 1; j <= 50; j++) {
            if (prefix[j] > 0) prefixCount++;
            if (suffix[j] > 0) suffixCount++;
        }

        diff[i] = prefixCount - suffixCount;
    }

    return diff;
}