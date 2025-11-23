int maxScore(int* nums, int numsSize) {
    int dp[1 << 14] = {0};
    int n = numsSize / 2;

    for (int mask = 0; mask < (1 << numsSize); mask++) {
        int count = __builtin_popcount(mask);
        if (count % 2 == 0) {
            int k = count / 2;
            for (int i = 0; i < numsSize; i++) {
                if (mask & (1 << i)) continue;
                for (int j = i + 1; j < numsSize; j++) {
                    if (mask & (1 << j)) continue;
                    int new_mask = mask | (1 << i) | (1 << j);
                    dp[new_mask] = fmax(dp[new_mask], dp[mask] + (k + 1) * gcd(nums[i], nums[j]));
                }
            }
        }
    }

    return dp[(1 << numsSize) - 1];
}

int gcd(int a, int b) {
    while (b) {
        int t = b;
        b = a % b;
        a = t;
    }
    return a;
}