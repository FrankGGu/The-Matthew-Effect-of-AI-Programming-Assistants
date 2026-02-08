int smallestMissingInteger(int* nums, int numsSize) {
    int *prefixSum = (int *)malloc((numsSize + 1) * sizeof(int));
    prefixSum[0] = 0;

    for (int i = 0; i < numsSize; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    int *seen = (int *)calloc(numsSize + 2, sizeof(int));

    for (int i = 1; i <= numsSize; i++) {
        if (prefixSum[i] <= numsSize) {
            seen[prefixSum[i]] = 1;
        }
    }

    for (int i = 1; i <= numsSize + 1; i++) {
        if (!seen[i]) {
            free(prefixSum);
            free(seen);
            return i;
        }
    }

    free(prefixSum);
    free(seen);
    return -1; // Just in case, should not reach here.
}