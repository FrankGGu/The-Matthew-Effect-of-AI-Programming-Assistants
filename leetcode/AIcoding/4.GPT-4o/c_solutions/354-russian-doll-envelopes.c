int maxEnvelopes(int** envelopes, int envelopesSize, int* envelopesColSize) {
    if (envelopesSize == 0) return 0;

    // Sort envelopes by width, and by height in descending order if widths are the same
    qsort(envelopes, envelopesSize, sizeof(int*), [](const void* a, const void* b) {
        if ((*((int**)a))[0] != (*((int**)b))[0]) {
            return (*((int**)a))[0] - (*((int**)b))[0];
        }
        return (*((int**)b))[1] - (*((int**)a))[1];
    });

    int* dp = (int*)malloc(envelopesSize * sizeof(int));
    int length = 0;

    for (int i = 0; i < envelopesSize; i++) {
        int height = envelopes[i][1];
        int left = 0, right = length;

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (dp[mid] < height) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        dp[left] = height;
        if (left == length) length++;
    }

    free(dp);
    return length;
}