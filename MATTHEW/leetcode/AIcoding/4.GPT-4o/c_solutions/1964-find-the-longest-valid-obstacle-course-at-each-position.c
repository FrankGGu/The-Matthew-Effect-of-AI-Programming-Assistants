int* longestObstacleCourseAtEachPosition(int* obstacles, int obstaclesSize, int* returnSize) {
    int* dp = (int*)malloc(obstaclesSize * sizeof(int));
    int* lis = (int*)malloc(obstaclesSize * sizeof(int));
    int len = 0;

    for (int i = 0; i < obstaclesSize; i++) {
        int pos = (int)(lower_bound(lis, lis + len, obstacles[i]) - lis);
        if (pos == len) len++;
        lis[pos] = obstacles[i];
        dp[i] = pos + 1;
    }

    *returnSize = obstaclesSize;
    free(lis);
    return dp;
}