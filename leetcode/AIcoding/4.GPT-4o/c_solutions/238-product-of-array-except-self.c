int* productExceptSelf(int* nums, int numsSize, int* returnSize) {
    int* output = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    int left = 1;
    for (int i = 0; i < numsSize; i++) {
        output[i] = left;
        left *= nums[i];
    }

    int right = 1;
    for (int i = numsSize - 1; i >= 0; i--) {
        output[i] *= right;
        right *= nums[i];
    }

    return output;
}