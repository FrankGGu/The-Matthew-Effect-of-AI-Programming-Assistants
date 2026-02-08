#define MOD 1000000007

int numberOfGoodSubsets(int* nums, int numsSize) {
    int count[31] = {0}, dp[1 << 10] = {0};
    dp[0] = 1;
    int prime_mask = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) count[0]++;
        else if (nums[i] > 1) count[nums[i]]++;
    }

    for (int i = 2; i <= 30; i++) {
        if (count[i] > 0) {
            int mask = 0, num = i;
            for (int j = 2; j * j <= num; j++) {
                if (num % j == 0) {
                    mask |= (1 << (j - 2));
                    while (num % j == 0) num /= j;
                }
            }
            if (num > 1) mask |= (1 << (num - 2));
            prime_mask |= mask;
            for (int j = (1 << 10) - 1; j >= 0; j--) {
                if ((j & mask) == 0) {
                    dp[j | mask] = (dp[j | mask] + 1LL * dp[j] * count[i]) % MOD;
                }
            }
        }
    }

    int result = 0;
    for (int i = 1; i < (1 << 10); i++) {
        result = (result + dp[i]) % MOD;
    }

    return (result + (count[0] > 0 ? (MOD + pow(2, count[0]) - 1) : 0)) % MOD;
}