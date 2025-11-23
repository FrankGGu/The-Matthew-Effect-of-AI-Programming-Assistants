#define MOD 1000000007

int countNicePairs(int* nums, int numsSize) {
    long long count = 0;
    long long freq[200001] = {0};

    for (int i = 0; i < numsSize; i++) {
        long long rev = 0, n = nums[i];
        while (n > 0) {
            rev = rev * 10 + n % 10;
            n /= 10;
        }
        long long key = (nums[i] - rev + 200000) % 200000;
        count = (count + freq[key]) % MOD;
        freq[key]++;
    }

    return (int)count;
}