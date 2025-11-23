int sumIndicesWithKSetBits(int* nums, int numsSize, int k) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        int count = 0;
        int n = i;
        while (n) {
            count += n & 1;
            n >>= 1;
        }
        if (count == k) {
            sum += nums[i];
        }
    }
    return sum;
}