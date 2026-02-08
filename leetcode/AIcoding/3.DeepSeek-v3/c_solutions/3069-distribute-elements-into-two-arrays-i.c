/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* resultArray(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* arr1 = (int*)malloc(numsSize * sizeof(int));
    int* arr2 = (int*)malloc(numsSize * sizeof(int));
    int idx1 = 0, idx2 = 0;

    arr1[idx1++] = nums[0];
    if (numsSize > 1) {
        arr2[idx2++] = nums[1];
    }

    for (int i = 2; i < numsSize; i++) {
        if (arr1[idx1 - 1] > arr2[idx2 - 1]) {
            arr1[idx1++] = nums[i];
        } else {
            arr2[idx2++] = nums[i];
        }
    }

    int* result = (int*)malloc(numsSize * sizeof(int));
    int idx = 0;
    for (int i = 0; i < idx1; i++) {
        result[idx++] = arr1[i];
    }
    for (int i = 0; i < idx2; i++) {
        result[idx++] = arr2[i];
    }

    free(arr1);
    free(arr2);
    return result;
}