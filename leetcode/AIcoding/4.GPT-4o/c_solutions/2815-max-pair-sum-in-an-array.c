int maxSumPairs(int* nums, int numsSize) {
    int maxPairSum = 0;
    int* sorted = (int*)malloc(numsSize * sizeof(int));
    memcpy(sorted, nums, numsSize * sizeof(int));
    qsort(sorted, numsSize, sizeof(int), cmp);

    for (int i = 0; i < numsSize / 2; i++) {
        int currentPairSum = sorted[i] + sorted[numsSize - 1 - i];
        if (currentPairSum > maxPairSum) {
            maxPairSum = currentPairSum;
        }
    }

    free(sorted);
    return maxPairSum;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}