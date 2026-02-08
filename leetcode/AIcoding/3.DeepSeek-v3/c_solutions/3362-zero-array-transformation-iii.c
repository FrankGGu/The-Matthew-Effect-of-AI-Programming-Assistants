int minZeroArray(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize) {
    int* diff = (int*)calloc(numsSize + 2, sizeof(int));
    int left = 0, right = queriesSize;

    while (left < right) {
        int mid = left + (right - left) / 2;

        memset(diff, 0, (numsSize + 2) * sizeof(int));
        for (int i = 0; i <= mid; i++) {
            int l = queries[i][0];
            int r = queries[i][1];
            int val = queries[i][2];
            diff[l] += val;
            diff[r + 1] -= val;
        }

        int valid = 1;
        int curr = 0;
        for (int i = 0; i < numsSize; i++) {
            curr += diff[i];
            if (curr < nums[i]) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    free(diff);

    if (left < queriesSize) {
        return left + 1;
    }

    memset(diff, 0, (numsSize + 2) * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        int l = queries[i][0];
        int r = queries[i][1];
        int val = queries[i][2];
        diff[l] += val;
        diff[r + 1] -= val;
    }

    int curr = 0;
    for (int i = 0; i < numsSize; i++) {
        curr += diff[i];
        if (curr < nums[i]) {
            return -1;
        }
    }

    return queriesSize;
}