#define MAX_DIGIT_SUM 82

int digitSum(int num) {
    int sum = 0;
    while (num > 0) {
        sum += num % 10;
        num /= 10;
    }
    return sum;
}

int maximumSum(int* nums, int numsSize) {
    int maxSum = -1;
    int maxNum[MAX_DIGIT_SUM + 1] = {0};

    for (int i = 0; i < numsSize; i++) {
        int dSum = digitSum(nums[i]);

        if (maxNum[dSum] > 0) {
            if (nums[i] + maxNum[dSum] > maxSum) {
                maxSum = nums[i] + maxNum[dSum];
            }
        }

        if (nums[i] > maxNum[dSum]) {
            maxNum[dSum] = nums[i];
        }
    }

    return maxSum;
}