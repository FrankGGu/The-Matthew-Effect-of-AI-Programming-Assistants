int numSubarraysWithSum(int* nums, int numsSize, int goal) {
    int count = 0;
    int sum = 0;
    int* prefixSum = (int*)calloc(numsSize + 1, sizeof(int));
    prefixSum[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        if (sum >= goal) {
            count += prefixSum[sum - goal];
        }
        prefixSum[sum]++;
    }

    free(prefixSum);
    return count;
}