int maximumBalancedSum(int* nums, int numsSize) {
    int sum = 0, maxSum = 0, balance = 0, leftCount = 0, rightCount = 0;
    int leftSum = 0, rightSum = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            leftCount++;
            leftSum += 1;
        } else {
            rightCount++;
            rightSum += nums[i];
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            balance++;
        } else {
            balance--;
        }

        if (balance < 0) {
            balance = 0;
        }

        if (balance == 0) {
            maxSum = leftSum + rightSum;
        }
    }

    return maxSum;
}