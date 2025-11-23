bool findSubarrays(int* nums, int numsSize) {
    if (numsSize < 3) return false;

    int* sums = (int*)malloc((numsSize - 1) * sizeof(int));

    for (int i = 0; i < numsSize - 1; i++) {
        sums[i] = nums[i] + nums[i + 1];
    }

    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = i + 1; j < numsSize - 1; j++) {
            if (sums[i] == sums[j]) {
                free(sums);
                return true;
            }
        }
    }

    free(sums);
    return false;
}