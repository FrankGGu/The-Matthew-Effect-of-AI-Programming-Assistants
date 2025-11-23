int waysToSplit(int* nums, int numsSize) {
    int mod = 1e9 + 7;
    int* prefix = (int*)malloc(numsSize * sizeof(int));
    prefix[0] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        prefix[i] = prefix[i - 1] + nums[i];
    }

    int total = prefix[numsSize - 1];
    int result = 0;

    for (int i = 0; i < numsSize - 2; i++) {
        int left = prefix[i];
        int remaining = total - left;
        if (remaining < left * 2) break;

        int low = i + 1, high = numsSize - 2;
        int minMid = -1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            int midSum = prefix[mid] - left;
            if (midSum >= left) {
                minMid = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        if (minMid == -1) continue;

        low = minMid;
        high = numsSize - 2;
        int maxMid = -1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            int midSum = prefix[mid] - left;
            int rightSum = total - prefix[mid];
            if (midSum <= rightSum) {
                maxMid = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        if (maxMid == -1) continue;

        result = (result + (maxMid - minMid + 1)) % mod;
    }

    free(prefix);
    return result;
}