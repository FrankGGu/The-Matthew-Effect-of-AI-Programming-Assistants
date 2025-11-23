int longestSquareStreak(int* nums, int numsSize) {
    int maxStreak = 0;
    int* squareSet = (int*)malloc(100001 * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        squareSet[nums[i]] = 1;
    }

    for (int i = 0; i < numsSize; i++) {
        int currentNum = nums[i];
        if (squareSet[currentNum] == 1) {
            int streak = 0;
            while (squareSet[currentNum] == 1) {
                streak++;
                squareSet[currentNum] = 0;
                currentNum++;
            }
            if (streak > 1) {
                maxStreak = fmax(maxStreak, streak);
            }
        }
    }

    free(squareSet);
    return maxStreak > 1 ? maxStreak : -1;
}