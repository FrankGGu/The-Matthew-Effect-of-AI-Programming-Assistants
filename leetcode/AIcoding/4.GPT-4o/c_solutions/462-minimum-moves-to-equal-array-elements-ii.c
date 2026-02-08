int minMoves2(int* nums, int numsSize) {
    int* sorted = malloc(numsSize * sizeof(int));
    memcpy(sorted, nums, numsSize * sizeof(int));
    qsort(sorted, numsSize, sizeof(int), cmp);

    int median = sorted[numsSize / 2];
    free(sorted);

    int moves = 0;
    for (int i = 0; i < numsSize; i++) {
        moves += abs(nums[i] - median);
    }

    return moves;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}