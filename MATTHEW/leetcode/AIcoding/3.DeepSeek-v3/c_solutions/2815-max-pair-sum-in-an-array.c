int maxSum(int* nums, int numsSize) {
    int maxDigit[10] = {0};
    int maxSum = -1;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int maxD = 0;

        while (num > 0) {
            int digit = num % 10;
            if (digit > maxD) maxD = digit;
            num /= 10;
        }

        if (maxDigit[maxD] > 0) {
            int sum = maxDigit[maxD] + nums[i];
            if (sum > maxSum) maxSum = sum;
        }

        if (nums[i] > maxDigit[maxD]) {
            maxDigit[maxD] = nums[i];
        }
    }

    return maxSum;
}