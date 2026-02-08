int findNumbers(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int digits = 0;
        int num = nums[i];
        while (num) {
            digits++;
            num /= 10;
        }
        if (digits % 2 == 0) {
            count++;
        }
    }
    return count;
}