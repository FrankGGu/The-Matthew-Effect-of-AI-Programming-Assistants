int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int minIncrementForUnique(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    qsort(nums, numsSize, sizeof(int), cmp);

    int moves = 0;
    int prev = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] <= prev) {
            moves += prev + 1 - nums[i];
            prev++;
        } else {
            prev = nums[i];
        }
    }

    return moves;
}