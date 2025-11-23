int countSubarrays(int* nums, int numsSize, int k) {
    int count = 0, prefixCount = 0;
    int* prefixSums = (int*)malloc((numsSize + 1) * sizeof(int));
    prefixSums[0] = 0;

    for (int i = 0; i < numsSize; ++i) {
        prefixSums[i + 1] = prefixSums[i] + (nums[i] < k ? -1 : nums[i] > k ? 1 : 0);
    }

    for (int i = 0; i <= numsSize; ++i) {
        for (int j = i + 1; j <= numsSize; ++j) {
            if (prefixSums[j] - prefixSums[i] == 0) {
                count++;
            }
        }
    }

    free(prefixSums);
    return count;
}