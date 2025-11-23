int countSubMultisets(int* nums, int numsSize, int l, int r) {
    const int MOD = 1000000007;
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }
    if (total < l) return 0;

    r = (r < total) ? r : total;

    int* dp = (int*)calloc(r + 2, sizeof(int));
    dp[0] = 1;

    int* count = (int*)calloc(20001, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    for (int v = 1; v <= 20000; v++) {
        if (count[v] == 0) continue;

        for (int j = r; j >= 0; j--) {
            if (dp[j] == 0) continue;

            for (int k = 1; k <= count[v]; k++) {
                int next = j + k * v;
                if (next > r) break;
                dp[next] = (dp[next] + dp[j]) % MOD;
            }
        }
    }

    int ans = 0;
    for (int s = l; s <= r; s++) {
        ans = (ans + dp[s]) % MOD;
    }

    free(dp);
    free(count);
    return ans;
}