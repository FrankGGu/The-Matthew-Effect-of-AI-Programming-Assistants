int cmp(const void* a, const void* b) {
    int* env1 = *(int**)a;
    int* env2 = *(int**)b;
    if (env1[0] == env2[0]) {
        return env2[1] - env1[1];
    }
    return env1[0] - env2[0];
}

int maxEnvelopes(int** envelopes, int envelopesSize, int* envelopesColSize) {
    if (envelopesSize == 0) return 0;

    qsort(envelopes, envelopesSize, sizeof(int*), cmp);

    int* heights = (int*)malloc(envelopesSize * sizeof(int));
    for (int i = 0; i < envelopesSize; i++) {
        heights[i] = envelopes[i][1];
    }

    int* dp = (int*)malloc(envelopesSize * sizeof(int));
    int len = 0;

    for (int i = 0; i < envelopesSize; i++) {
        int left = 0, right = len;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (dp[mid] < heights[i]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        dp[left] = heights[i];
        if (left == len) {
            len++;
        }
    }

    free(heights);
    free(dp);
    return len;
}