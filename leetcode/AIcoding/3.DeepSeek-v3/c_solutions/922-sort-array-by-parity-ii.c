/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* sortArrayByParityII(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));
    int evenIndex = 0;
    int oddIndex = 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            result[evenIndex] = nums[i];
            evenIndex += 2;
        } else {
            result[oddIndex] = nums[i];
            oddIndex += 2;
        }
    }

    return result;
}