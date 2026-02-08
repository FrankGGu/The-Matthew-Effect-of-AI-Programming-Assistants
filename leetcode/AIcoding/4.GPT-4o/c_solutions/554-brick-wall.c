int leastBricks(int** wall, int wallSize, int* wallColSize) {
    int* count = (int*)calloc(10001, sizeof(int));
    int maxCount = 0;

    for (int i = 0; i < wallSize; i++) {
        int sum = 0;
        for (int j = 0; j < wallColSize[i] - 1; j++) {
            sum += wall[i][j];
            count[sum]++;
            if (count[sum] > maxCount) {
                maxCount = count[sum];
            }
        }
    }

    free(count);
    return wallSize - maxCount;
}