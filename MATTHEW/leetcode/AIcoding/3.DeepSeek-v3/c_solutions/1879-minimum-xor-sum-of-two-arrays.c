int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int minimumXORSum(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int n = nums1Size;
    int dp[1 << 14];
    int limit = 1 << n;

    for (int i = 0; i < limit; i++) {
        dp[i] = 2000000000;
    }

    dp[0] = 0;

    for (int mask = 0; mask < limit; mask++) {
        int j = __builtin_popcount(mask);
        for (int i = 0; i < n; i++) {
            if (!(mask & (1 << i))) {
                int new_mask = mask | (1 << i);
                int val = dp[mask] + (nums1[j] ^ nums2[i]);
                if (val < dp[new_mask]) {
                    dp[new_mask] = val;
                }
            }
        }
    }

    return dp[limit - 1];
}