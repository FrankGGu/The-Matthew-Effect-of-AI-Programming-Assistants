int maxSum(int* nums, int numsSize, int k) {
    int count[32] = {0};
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < 31; j++) {
            if (nums[i] & (1 << j)) {
                count[j]++;
            }
        }
    }

    long long result = 0;
    long long mod = 1e9 + 7;

    for (int i = 0; i < k; i++) {
        long long x = 0;
        for (int j = 0; j < 31; j++) {
            if (count[j] > 0) {
                x |= (1 << j);
                count[j]--;
            }
        }
        result = (result + x * x) % mod;
    }

    return result;
}