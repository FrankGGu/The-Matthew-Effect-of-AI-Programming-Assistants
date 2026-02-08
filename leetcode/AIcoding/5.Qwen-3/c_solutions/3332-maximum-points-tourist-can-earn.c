#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxPoints(int* points, int pointsSize) {
    if (pointsSize == 0) return 0;
    if (pointsSize == 1) return points[0];

    qsort(points, pointsSize, sizeof(int), compare);

    int* dp = (int*)malloc(pointsSize * sizeof(int));
    dp[0] = points[0];

    for (int i = 1; i < pointsSize; i++) {
        int maxVal = 0;
        for (int j = 0; j < i; j++) {
            if (points[i] - points[j] > 1) {
                maxVal = (maxVal > dp[j]) ? maxVal : dp[j];
            }
        }
        dp[i] = maxVal + points[i];
    }

    int result = 0;
    for (int i = 0; i < pointsSize; i++) {
        result = (result > dp[i]) ? result : dp[i];
    }

    free(dp);
    return result;
}