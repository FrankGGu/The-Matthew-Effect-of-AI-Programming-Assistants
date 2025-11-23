int scheduleCourse(int** courses, int coursesSize, int* coursesColSize) {
    int maxCourses = 0;
    int* dp = (int*)malloc((10001) * sizeof(int));
    for (int i = 0; i < 10001; i++) dp[i] = 0;

    qsort(courses, coursesSize, sizeof(int*), cmp);

    for (int i = 0; i < coursesSize; i++) {
        int duration = courses[i][0];
        int endTime = courses[i][1];
        for (int j = maxCourses; j >= 0; j--) {
            if (dp[j] + duration <= endTime) {
                dp[j + 1] = fmax(dp[j + 1], dp[j] + duration);
                maxCourses = fmax(maxCourses, j + 1);
            }
        }
    }

    free(dp);
    return maxCourses;
}

int cmp(const void* a, const void* b) {
    return (*(int**)a)[1] - (*(int**)b)[1];
}