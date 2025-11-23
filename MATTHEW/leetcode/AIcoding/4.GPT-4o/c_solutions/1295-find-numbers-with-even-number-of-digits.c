int findNumbers(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int digitCount = 0;
        int num = nums[i];
        while (num > 0) {
            digitCount++;
            num /= 10;
        }
        if (digitCount % 2 == 0) {
            count++;
        }
    }
    return count;
}