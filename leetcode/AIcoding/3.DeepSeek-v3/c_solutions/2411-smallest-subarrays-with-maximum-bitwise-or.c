/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* smallestSubarrays(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    int last[32] = {0};
    for (int i = 0; i < 32; i++) {
        last[i] = -1;
    }

    for (int i = numsSize - 1; i >= 0; i--) {
        result[i] = 1;
        for (int j = 0; j < 32; j++) {
            if (nums[i] >> j & 1) {
                last[j] = i;
            }
        }

        int maxLast = i;
        for (int j = 0; j < 32; j++) {
            if (last[j] != -1 && last[j] > maxLast) {
                maxLast = last[j];
            }
        }

        if (maxLast != -1) {
            result[i] = maxLast - i + 1;
        }
    }

    return result;
}