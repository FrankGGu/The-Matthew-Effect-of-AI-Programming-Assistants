/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* transformArray(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));
    if (result == NULL) {
        return NULL;
    }

    int evenIndex = 0;
    int oddIndex = numsSize - 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            result[evenIndex++] = nums[i];
        } else {
            result[oddIndex--] = nums[i];
        }
    }

    return result;
}