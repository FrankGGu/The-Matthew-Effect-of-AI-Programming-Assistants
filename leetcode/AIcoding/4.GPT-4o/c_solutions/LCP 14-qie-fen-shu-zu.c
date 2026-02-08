int minimumAverageDifference(int* nums, int numsSize) {
    long totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    long leftSum = 0;
    int minIndex = -1;
    long minDiff = LONG_MAX;

    for (int i = 0; i < numsSize; i++) {
        leftSum += nums[i];
        long rightSum = totalSum - leftSum;
        long leftAvg = leftSum / (i + 1);
        long rightAvg = (i == numsSize - 1) ? 0 : rightSum / (numsSize - i - 1);
        long diff = labs(leftAvg - rightAvg);

        if (diff < minDiff) {
            minDiff = diff;
            minIndex = i;
        }
    }

    return minIndex;
}