int* applyOperations(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int index = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i < numsSize - 1 && nums[i] == nums[i + 1]) {
            result[index++] = nums[i] * 2;
            i++;
        } else {
            result[index++] = nums[i];
        }
    }

    for (int i = index; i < numsSize; i++) {
        result[i] = 0;
    }

    *returnSize = numsSize;
    return result;
}