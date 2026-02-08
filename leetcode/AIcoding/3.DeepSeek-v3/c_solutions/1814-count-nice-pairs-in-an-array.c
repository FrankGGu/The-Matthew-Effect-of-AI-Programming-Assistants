int rev(int num) {
    int reversed = 0;
    while (num > 0) {
        reversed = reversed * 10 + num % 10;
        num /= 10;
    }
    return reversed;
}

int countNicePairs(int* nums, int numsSize) {
    const int MOD = 1000000007;
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        nums[i] = nums[i] - rev(nums[i]);
    }

    int freq[20001] = {0};

    for (int i = 0; i < numsSize; i++) {
        count = (count + freq[nums[i] + 10000]) % MOD;
        freq[nums[i] + 10000]++;
    }

    return count;
}