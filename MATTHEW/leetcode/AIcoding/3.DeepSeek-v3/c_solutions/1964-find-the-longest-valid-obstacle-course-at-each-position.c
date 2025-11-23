int* longestObstacleCourseAtEachPosition(int* obstacles, int obstaclesSize, int* returnSize) {
    int* result = (int*)malloc(obstaclesSize * sizeof(int));
    int* dp = (int*)malloc(obstaclesSize * sizeof(int));
    int len = 0;

    for (int i = 0; i < obstaclesSize; i++) {
        int left = 0, right = len;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (dp[mid] <= obstacles[i]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        result[i] = left + 1;
        if (left == len) {
            dp[len++] = obstacles[i];
        } else {
            dp[left] = obstacles[i];
        }
    }

    free(dp);
    *returnSize = obstaclesSize;
    return result;
}