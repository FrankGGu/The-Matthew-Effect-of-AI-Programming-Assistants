int squareFreeSubsets(int* nums, int numsSize) {
    int mod = 1e9 + 7;
    int count[32] = {0};
    int mask = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (num == 0) continue;
        int prime_factors = 0;
        for (int j = 2; j * j <= num; j++) {
            if (num % (j * j) == 0) {
                prime_factors = -1;
                break;
            }
            if (num % j == 0) {
                prime_factors |= (1 << (j - 1));
                while (num % j == 0) num /= j;
            }
        }
        if (num > 1) prime_factors |= (1 << (num - 1));
        if (prime_factors != -1) {
            mask |= prime_factors;
            count[prime_factors]++;
        }
    }

    long long dp[1 << 10] = {1};

    for (int i = 0; i < (1 << 10); i++) {
        if (dp[i] == 0) continue;
        for (int j = 0; j < (1 << 10); j++) {
            if ((i & j) == 0) {
                dp[i | j] = (dp[i | j] + dp[i] * count[j]) % mod;
            }
        }
    }

    return (dp[mask] - 1 + mod) % mod;
}