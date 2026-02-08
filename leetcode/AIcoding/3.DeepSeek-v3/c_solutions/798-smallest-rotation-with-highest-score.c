int bestRotation(int* nums, int numsSize) {
    int* diff = (int*)calloc(numsSize + 1, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] <= i) {
            diff[0]++;
            diff[i - nums[i] + 1]--;
            diff[i + 1]++;
            diff[numsSize]--;
        } else {
            diff[i + 1]++;
            diff[numsSize - nums[i] + i + 1]--;
        }
    }

    int maxScore = 0;
    int score = 0;
    int bestK = 0;

    for (int k = 0; k < numsSize; k++) {
        score += diff[k];
        if (score > maxScore) {
            maxScore = score;
            bestK = k;
        }
    }

    free(diff);
    return bestK;
}