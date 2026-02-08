int* sortArrayByParityII(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;
    int evenPtr = 0;
    int oddPtr = 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            result[evenPtr] = nums[i];
            evenPtr += 2;
        } else {
            result[oddPtr] = nums[i];
            oddPtr += 2;
        }
    }
    return result;
}