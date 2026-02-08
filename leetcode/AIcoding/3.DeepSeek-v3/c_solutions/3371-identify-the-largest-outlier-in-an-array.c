int getLargestOutlier(int* nums, int numsSize) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    int maxOutlier = -1000000;

    for (int i = 0; i < numsSize; i++) {
        int current = nums[i];
        int remainingSum = sum - current;

        if (remainingSum % 2 != 0) continue;

        int target = remainingSum / 2;

        for (int j = 0; j < numsSize; j++) {
            if (j == i) continue;
            if (nums[j] == target) {
                if (current > maxOutlier) {
                    maxOutlier = current;
                }
                break;
            }
        }
    }

    return maxOutlier;
}