int cmp(const void *a, const void *b) {
    return *(long long*)b - *(long long*)a;
}

long long minSumSquareDiff(int* nums1, int nums1Size, int* nums2, int nums2Size, int k1, int k2) {
    int n = nums1Size;
    long long *diff = (long long*)malloc(n * sizeof(long long));
    for (int i = 0; i < n; i++) {
        diff[i] = abs((long long)nums1[i] - nums2[i]);
    }

    int k = k1 + k2;
    long long total_diff = 0;
    for (int i = 0; i < n; i++) {
        total_diff += diff[i];
    }
    if (total_diff <= k) return 0;

    qsort(diff, n, sizeof(long long), cmp);

    diff[n] = 0;
    for (int i = 1; i <= n; i++) {
        long long dec = (diff[i-1] - diff[i]) * i;
        if (dec <= k) {
            k -= dec;
        } else {
            long long a = k / i;
            long long b = k % i;
            for (int j = 0; j < i; j++) {
                if (j < b) {
                    diff[j] = diff[i-1] - a - 1;
                } else {
                    diff[j] = diff[i-1] - a;
                }
            }
            break;
        }
    }

    long long res = 0;
    for (int i = 0; i < n; i++) {
        res += diff[i] * diff[i];
    }
    free(diff);
    return res;
}