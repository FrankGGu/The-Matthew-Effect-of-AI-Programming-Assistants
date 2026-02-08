int numberOfGoodSubarraySplits(int* nums, int numsSize) {
    long long mod = 1e9 + 7;
    int firstOne = -1;
    int lastOne = -1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            if (firstOne == -1) firstOne = i;
            lastOne = i;
        }
    }

    if (firstOne == -1) return 0;
    if (firstOne == lastOne) return 1;

    long long result = 1;
    int prevOne = firstOne;

    for (int i = firstOne + 1; i <= lastOne; i++) {
        if (nums[i] == 1) {
            result = (result * (i - prevOne)) % mod;
            prevOne = i;
        }
    }

    return (int)result;
}