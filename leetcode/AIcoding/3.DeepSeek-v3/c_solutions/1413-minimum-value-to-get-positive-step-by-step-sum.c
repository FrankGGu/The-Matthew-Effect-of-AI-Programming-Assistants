int minStartValue(int* nums, int numsSize) {
    int minSum = 0;
    int sum = 0;

    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        if (sum < minSum) {
            minSum = sum;
        }
    }

    return 1 - minSum;
}