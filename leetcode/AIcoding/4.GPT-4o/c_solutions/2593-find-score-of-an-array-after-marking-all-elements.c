int findScore(int* nums, int numsSize) {
    int* marked = (int*)calloc(numsSize, sizeof(int));
    int score = 0;

    for (int i = 0; i < numsSize; i++) {
        if (!marked[i]) {
            score += nums[i];
            marked[i] = 1;
            for (int j = i + 1; j < numsSize; j++) {
                if (nums[j] == nums[i]) {
                    marked[j] = 1;
                }
            }
        }
    }

    free(marked);
    return score;
}