int* pivotArray(int* nums, int numsSize, int pivot, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;
    int k = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < pivot) {
            result[k++] = nums[i];
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == pivot) {
            result[k++] = nums[i];
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > pivot) {
            result[k++] = nums[i];
        }
    }

    return result;
}