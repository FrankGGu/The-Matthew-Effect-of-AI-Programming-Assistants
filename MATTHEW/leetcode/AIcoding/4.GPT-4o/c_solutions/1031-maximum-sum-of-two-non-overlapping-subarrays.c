int maxSumTwoNoOverlap(int* nums, int numsSize, int firstLen, int secondLen) {
    int maxSum = 0;

    for (int i = 0; i <= numsSize - firstLen; i++) {
        int firstSum = 0;
        for (int j = i; j < i + firstLen; j++) {
            firstSum += nums[j];
        }
        int secondMax = 0;
        for (int j = 0; j <= numsSize - secondLen; j++) {
            if (j + secondLen <= i || j >= i + firstLen) {
                int secondSum = 0;
                for (int k = j; k < j + secondLen; k++) {
                    secondSum += nums[k];
                }
                if (secondSum > secondMax) {
                    secondMax = secondSum;
                }
            }
        }
        if (firstSum + secondMax > maxSum) {
            maxSum = firstSum + secondMax;
        }
    }

    for (int i = 0; i <= numsSize - secondLen; i++) {
        int secondSum = 0;
        for (int j = i; j < i + secondLen; j++) {
            secondSum += nums[j];
        }
        int firstMax = 0;
        for (int j = 0; j <= numsSize - firstLen; j++) {
            if (j + firstLen <= i || j >= i + secondLen) {
                int firstSum = 0;
                for (int k = j; k < j + firstLen; k++) {
                    firstSum += nums[k];
                }
                if (firstSum > firstMax) {
                    firstMax = firstSum;
                }
            }
        }
        if (firstMax + secondSum > maxSum) {
            maxSum = firstMax + secondSum;
        }
    }

    return maxSum;
}