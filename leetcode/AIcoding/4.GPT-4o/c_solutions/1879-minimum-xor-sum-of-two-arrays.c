#define MAXN 16
#define MAXS 1 << 16

int dp[MAXN][MAXS];

int minXORSum(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    memset(dp, 0x3f, sizeof(dp));
    dp[0][0] = 0;
    for (int i = 0; i < nums1Size; i++) {
        for (int j = 0; j < (1 << i); j++) {
            for (int k = 0; k < nums2Size; k++) {
                if (j & (1 << k)) continue;
                int new_mask = j | (1 << k);
                dp[i + 1][new_mask] = fmin(dp[i + 1][new_mask], dp[i][j] + (nums1[i] ^ nums2[k]));
            }
        }
    }
    return dp[nums1Size][(1 << nums2Size) - 1];
}