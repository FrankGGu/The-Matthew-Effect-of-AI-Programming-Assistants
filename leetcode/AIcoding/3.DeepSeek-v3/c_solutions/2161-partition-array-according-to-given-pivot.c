/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* pivotArray(int* nums, int numsSize, int pivot, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));
    int left = 0, right = numsSize - 1;
    int* temp = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < pivot) {
            result[left++] = nums[i];
        }
        temp[i] = nums[i];
    }

    for (int i = numsSize - 1; i >= 0; i--) {
        if (temp[i] > pivot) {
            result[right--] = temp[i];
        }
    }

    while (left <= right) {
        result[left++] = pivot;
    }

    free(temp);
    return result;
}