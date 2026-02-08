int minDeletions(int* nums, int numsSize, int* divisors, int divisorsSize) {
    int min_deletions = INT_MAX;

    for (int i = 0; i < divisorsSize; i++) {
        int divisor = divisors[i];
        int deletions = 0;

        for (int j = 0; j < numsSize; j++) {
            if (nums[j] % divisor != 0) {
                deletions++;
            }
        }

        if (deletions < min_deletions) {
            min_deletions = deletions;
        }
    }

    return min_deletions == INT_MAX ? -1 : min_deletions;
}