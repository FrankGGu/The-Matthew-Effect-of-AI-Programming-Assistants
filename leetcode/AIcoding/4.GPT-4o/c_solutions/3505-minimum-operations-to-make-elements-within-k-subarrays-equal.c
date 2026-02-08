int minOperations(int* nums, int numsSize, int k) {
    int maxNum = 100000;
    int* count = (int*)calloc(maxNum + 1, sizeof(int));
    int minOps = numsSize;

    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
        if (i >= k) {
            count[nums[i - k]]--;
        }
        if (i >= k - 1) {
            int ops = k - count[nums[i]];
            for (int j = 0; j <= maxNum; j++) {
                if (count[j] > 0) {
                    ops = fmin(ops, k - count[j]);
                }
            }
            minOps = fmin(minOps, ops);
        }
    }

    free(count);
    return minOps;
}