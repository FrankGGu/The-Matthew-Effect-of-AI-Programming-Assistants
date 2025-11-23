int minimumAverageDifference(int* nums, int numsSize) {
    long long totalSum = 0, leftSum = 0;
    for (int i = 0; i < numsSize; i++) totalSum += nums[i];

    int minIndex = 0;
    long long minAvgDiff = LLONG_MAX;

    for (int i = 0; i < numsSize; i++) {
        leftSum += nums[i];
        long long leftAvg = leftSum / (i + 1);
        long long rightAvg = (i == numsSize - 1) ? 0 : (totalSum - leftSum) / (numsSize - i - 1);
        long long avgDiff = llabs(leftAvg - rightAvg);

        if (avgDiff < minAvgDiff) {
            minAvgDiff = avgDiff;
            minIndex = i;
        }
    }

    return minIndex;
}