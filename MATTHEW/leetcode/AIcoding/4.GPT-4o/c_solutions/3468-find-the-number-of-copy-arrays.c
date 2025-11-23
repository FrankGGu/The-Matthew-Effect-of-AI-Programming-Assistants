int countCopyArrays(int* nums, int numsSize) {
    long long mod = 1e9 + 7;
    long long result = 1;
    long long count = 1;
    int prev = -1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != prev) {
            count = 1;
        } else {
            count++;
        }
        result = (result * count) % mod;
        prev = nums[i];
    }

    return (int)result;
}