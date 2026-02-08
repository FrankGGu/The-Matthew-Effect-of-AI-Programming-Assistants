#include <stdlib.h>

int* pointsInsideCircles(int** points, int pointsSize, int* pointsColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* ans = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;

    for (int j = 0; j < queriesSize; j++) {
        int cx = queries[j][0];
        int cy = queries[j][1];
        int r = queries[j][2];

        int count = 0;

        long long rSq = (long long)r * r;

        for (int i = 0; i < pointsSize; i++) {
            int px = points[i][0];
            int py = points[i][1];

            long long dx = px - cx;
            long long dy = py - cy;
            long long distSq = dx * dx + dy * dy;

            if (distSq <= rSq) {
                count++;
            }
        }
        ans[j] = count;
    }

    return ans;
}