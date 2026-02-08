int maxSumTwoNoOverlap(int* nums, int numsSize, int firstLen, int secondLen) {
    int* prefixSum = (int*)malloc((numsSize + 1) * sizeof(int));
    prefixSum[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    int maxSum = 0;

    for (int i = 0; i <= numsSize - firstLen; i++) {
        int firstSum = prefixSum[i + firstLen] - prefixSum[i];

        for (int j = 0; j <= numsSize - secondLen; j++) {
            if ((j >= i + firstLen) || (j + secondLen <= i)) {
                int secondSum = prefixSum[j + secondLen] - prefixSum[j];
                if (firstSum + secondSum > maxSum) {
                    maxSum = firstSum + secondSum;
                }
            }
        }
    }

    free(prefixSum);
    return maxSum;
}