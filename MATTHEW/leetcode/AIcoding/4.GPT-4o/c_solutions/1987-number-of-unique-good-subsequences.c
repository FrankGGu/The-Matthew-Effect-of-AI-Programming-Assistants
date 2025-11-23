#define MOD 1000000007

int countGoodSubsequences(char * nums) {
    long long count[2] = {0, 0};
    long long total = 0;

    for (int i = 0; nums[i] != '\0'; i++) {
        int digit = nums[i] - '0';
        count[digit]++;
        total = (total * 2 + 1) % MOD;
    }

    if (count[0] > 0) {
        total = (total - 1 + MOD) % MOD;
    }
    return (total + (count[1] > 0 ? 1 : 0)) % MOD;
}