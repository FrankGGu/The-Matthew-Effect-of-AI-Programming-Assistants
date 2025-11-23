int squareFreeSubsets(int* nums, int numsSize) {
    int primes[] = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
    int masks[31];
    for (int i = 0; i <= 30; i++) masks[i] = 0;
    for (int i = 2; i <= 30; i++) {
        int x = i;
        for (int j = 0; j < 10; j++) {
            int p = primes[j];
            if (x % p == 0) {
                if (x % (p * p) == 0) {
                    masks[i] = -1;
                    break;
                }
                masks[i] |= (1 << j);
                x /= p;
            }
        }
    }

    int mod = 1000000007;
    int dp[1 << 10];
    for (int i = 0; i < (1 << 10); i++) dp[i] = 0;
    dp[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (masks[num] == -1) continue;
        int mask = masks[num];
        for (int j = (1 << 10) - 1; j >= 0; j--) {
            if ((j & mask) == 0) {
                dp[j | mask] = (dp[j | mask] + dp[j]) % mod;
            }
        }
    }

    long long ans = 0;
    for (int i = 0; i < (1 << 10); i++) {
        ans = (ans + dp[i]) % mod;
    }
    return (ans - 1 + mod) % mod;
}