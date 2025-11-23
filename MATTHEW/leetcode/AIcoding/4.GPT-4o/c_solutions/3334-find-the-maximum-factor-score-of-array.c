int maxFactorScore(int* nums, int numsSize) {
    int maxScore = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = 1; j <= nums[i]; j++) {
            if (nums[i] % j == 0) {
                int factorCount = 0;
                for (int k = 0; k < numsSize; k++) {
                    if (nums[k] % j == 0) {
                        factorCount++;
                    }
                }
                if (factorCount > maxScore) {
                    maxScore = factorCount;
                }
            }
        }
    }
    return maxScore;
}