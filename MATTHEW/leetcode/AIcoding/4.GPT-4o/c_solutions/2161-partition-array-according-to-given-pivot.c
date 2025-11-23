void pivotArray(int* nums, int numsSize, int pivot, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int left = 0, right = numsSize - 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < pivot) {
            result[left++] = nums[i];
        } else if (nums[i] > pivot) {
            result[right--] = nums[i];
        }
    }

    for (int i = left; i <= right; i++) {
        result[i] = pivot;
    }

    memcpy(nums, result, numsSize * sizeof(int));
    *returnSize = numsSize;
    free(result);
}