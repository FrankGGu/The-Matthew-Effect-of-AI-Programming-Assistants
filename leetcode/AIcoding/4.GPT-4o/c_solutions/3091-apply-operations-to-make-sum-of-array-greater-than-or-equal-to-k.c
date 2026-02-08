int minOperations(int* nums, int numsSize, int k) {
    int sum = 0, operations = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    if (sum >= k) return 0;

    int needed = k - sum;
    int* freq = (int*)calloc(needed + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] <= needed) {
            freq[nums[i]]++;
        }
    }

    for (int i = needed; i > 0; i--) {
        while (freq[i] > 0 && needed > 0) {
            needed -= i;
            operations++;
            freq[i]--;
        }
    }

    free(freq);
    return needed > 0 ? -1 : operations;
}