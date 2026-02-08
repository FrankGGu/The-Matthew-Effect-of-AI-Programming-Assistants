int maxScore(int* nums, int numsSize) {
    int score = 0;
    int* visited = (int*)calloc(numsSize, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        if (visited[i] == 0) {
            score += nums[i];
            visited[i] = 1;
            for (int j = i + 1; j < numsSize; j++) {
                if (nums[j] == nums[i]) {
                    visited[j] = 1;
                }
            }
        }
    }
    free(visited);
    return score;
}