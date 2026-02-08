#define MOD 1000000007

int countWays(int* nums, int numsSize) {
    long long count[1001] = {0};
    count[1] = 1;

    for (int i = 0; i < numsSize; i++) {
        for (int j = 1000; j >= 1; j--) {
            if (count[j] > 0) {
                for (int k = 1; j * k <= 1000; k++) {
                    count[j * k] = (count[j * k] + count[j]) % MOD;
                }
            }
        }
        count[nums[i]] = (count[nums[i]] + 1) % MOD;
    }

    long long result = 0;
    for (int i = 1; i <= 1000; i++) {
        result = (result + count[i]) % MOD;
    }

    return (int)result;
}