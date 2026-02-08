int minMoves(int* nums, int numsSize, int k) {
    if (k == 1) return 0;

    int* ones = (int*)malloc(numsSize * sizeof(int));
    int onesCount = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            ones[onesCount++] = i;
        }
    }

    int* prefix = (int*)malloc((onesCount + 1) * sizeof(int));
    prefix[0] = 0;
    for (int i = 0; i < onesCount; i++) {
        prefix[i + 1] = prefix[i] + ones[i];
    }

    int res = INT_MAX;
    int radius = (k - 1) / 2;

    for (int l = 0; l + k <= onesCount; l++) {
        int r = l + k - 1;
        int mid = l + radius;
        int left = prefix[mid] - prefix[l];
        int right = prefix[r + 1] - prefix[mid + 1];

        int cost = right - left;
        if (k % 2 == 0) {
            cost -= ones[mid];
        }

        cost -= radius * (radius + 1);
        if (k % 2 == 0) {
            cost -= radius + 1;
        }

        if (cost < res) {
            res = cost;
        }
    }

    free(ones);
    free(prefix);
    return res;
}