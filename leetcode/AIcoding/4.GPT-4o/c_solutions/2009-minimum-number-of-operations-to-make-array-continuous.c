int minOperations(int* nums, int numsSize) {
    int* sorted = malloc(numsSize * sizeof(int));
    memcpy(sorted, nums, numsSize * sizeof(int));
    qsort(sorted, numsSize, sizeof(int), cmp);

    int left = 0, minOps = numsSize;
    for (int right = 0; right < numsSize; right++) {
        while (sorted[right] - sorted[left] > numsSize - 1) {
            left++;
        }
        minOps = fmin(minOps, numsSize - (right - left + 1));
    }

    free(sorted);
    return minOps;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}