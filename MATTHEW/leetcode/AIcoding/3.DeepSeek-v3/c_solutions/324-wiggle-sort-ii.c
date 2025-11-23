int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

void wiggleSort(int* nums, int numsSize) {
    int* sorted = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }
    qsort(sorted, numsSize, sizeof(int), cmp);

    int j = numsSize - 1;
    for (int i = 1; i < numsSize; i += 2) {
        nums[i] = sorted[j--];
    }
    for (int i = 0; i < numsSize; i += 2) {
        nums[i] = sorted[j--];
    }

    free(sorted);
}