int* sortArray(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        result[i] = nums[i];
    }
    qsort(result, numsSize, sizeof(int), cmp);
    *returnSize = numsSize;
    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}