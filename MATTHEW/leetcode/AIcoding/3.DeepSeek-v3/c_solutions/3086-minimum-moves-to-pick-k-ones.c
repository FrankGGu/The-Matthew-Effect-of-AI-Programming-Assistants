int minMoves(int* nums, int numsSize, int k, int maxChanges) {
    long long *pos = (long long*)malloc(numsSize * sizeof(long long));
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            pos[count++] = i;
        }
    }

    long long *prefix = (long long*)malloc((count + 1) * sizeof(long long));
    prefix[0] = 0;
    for (int i = 0; i < count; i++) {
        prefix[i + 1] = prefix[i] + pos[i];
    }

    long long result = 1LL << 60;
    int radius = k - maxChanges;
    if (radius > 0) {
        for (int l = 0; l + radius <= count; l++) {
            int r = l + radius - 1;
            int m = (l + r) / 2;
            long long left = pos[m] * (m - l) - (prefix[m] - prefix[l]);
            long long right = (prefix[r + 1] - prefix[m + 1]) - pos[m] * (r - m);
            long long total = left + right;
            if (total < result) {
                result = total;
            }
        }
    } else {
        result = 0;
    }

    free(pos);
    free(prefix);
    return result + 2LL * maxChanges;
}