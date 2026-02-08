int totalHammingDistance(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < 32; i++) {
        int ones = 0;
        for (int j = 0; j < numsSize; j++) {
            ones += (nums[j] >> i) & 1;
        }
        total += ones * (numsSize - ones);
    }
    return total;
}