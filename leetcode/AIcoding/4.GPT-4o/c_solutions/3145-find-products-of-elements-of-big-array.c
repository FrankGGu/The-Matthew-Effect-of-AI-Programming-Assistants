int* productExceptSelf(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int* leftProducts = (int*)malloc(numsSize * sizeof(int));
    int* rightProducts = (int*)malloc(numsSize * sizeof(int));

    leftProducts[0] = 1;
    for (int i = 1; i < numsSize; i++) {
        leftProducts[i] = leftProducts[i - 1] * nums[i - 1];
    }

    rightProducts[numsSize - 1] = 1;
    for (int i = numsSize - 2; i >= 0; i--) {
        rightProducts[i] = rightProducts[i + 1] * nums[i + 1];
    }

    for (int i = 0; i < numsSize; i++) {
        result[i] = leftProducts[i] * rightProducts[i];
    }

    free(leftProducts);
    free(rightProducts);

    *returnSize = numsSize;
    return result;
}