int minElement(int* nums, int numsSize) {
    int min_val = INT_MAX;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        if (sum < min_val) {
            min_val = sum;
        }
    }
    return min_val;
}