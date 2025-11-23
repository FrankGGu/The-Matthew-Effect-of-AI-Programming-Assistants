int minMaxGame(int* nums, int numsSize) {
    if (numsSize == 1) {
        return nums[0];
    }

    int n = numsSize;
    while (n > 1) {
        int newN = n / 2;
        for (int i = 0; i < newN; i++) {
            if (i % 2 == 0) { // Even index, take min
                nums[i] = (nums[2 * i] < nums[2 * i + 1]) ? nums[2 * i] : nums[2 * i + 1];
            } else { // Odd index, take max
                nums[i] = (nums[2 * i] > nums[2 * i + 1]) ? nums[2 * i] : nums[2 * i + 1];
            }
        }
        n = newN;
    }
    return nums[0];
}