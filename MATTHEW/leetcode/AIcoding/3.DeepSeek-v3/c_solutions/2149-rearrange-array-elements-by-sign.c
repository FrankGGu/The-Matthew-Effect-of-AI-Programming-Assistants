/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* rearrangeArray(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    int posIndex = 0, negIndex = 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            result[posIndex] = nums[i];
            posIndex += 2;
        } else {
            result[negIndex] = nums[i];
            negIndex += 2;
        }
    }

    return result;
}