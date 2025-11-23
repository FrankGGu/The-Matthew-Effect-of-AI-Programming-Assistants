int maximumScore(int* nums, int numsSize, int k) {
    int maxScore = 0;
    for (int i = 0; i < numsSize; i++) {
        int minValue = nums[i];
        for (int j = i; j < numsSize; j++) {
            if (nums[j] < minValue) minValue = nums[j];
            if ((j - i + 1) >= k) {
                int score = minValue * (j - i + 1);
                if (score > maxScore) maxScore = score;
            }
        }
    }
    return maxScore;
}