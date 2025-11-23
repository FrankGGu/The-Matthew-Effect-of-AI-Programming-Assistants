int sumOfDistances(int* nums, int numsSize) {
    long long total = 0;
    long long* count = (long long*)calloc(100001, sizeof(long long));
    long long* prefixSum = (long long*)calloc(100001, sizeof(long long));

    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
        prefixSum[nums[i]] += i;
    }

    for (int i = 0; i < 100001; i++) {
        if (count[i] > 0) {
            long long c = count[i];
            long long sum = prefixSum[i];
            total += c * (sum - (c * (c - 1) / 2));
        }
    }

    free(count);
    free(prefixSum);
    return total;
}