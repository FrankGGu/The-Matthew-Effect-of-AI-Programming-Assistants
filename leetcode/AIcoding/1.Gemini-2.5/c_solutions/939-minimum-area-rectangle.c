#include <stdlib.h>

int compareLongLong(const void *a, const void *b) {
    long long valA = *(const long long *)a;
    long long valB = *(const long long *)b;
    if (valA < valB) return -1;
    if (valA > valB) return 1;
    return 0;
}

int minAreaRect(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize < 4) {
        return 0;
    }

    long long* pointKeys = (long long*)malloc(pointsSize * sizeof(long long));
    if (pointKeys == NULL) {
        return 0;
    }

    for (int i = 0; i < pointsSize; ++i) {
        pointKeys[i] = (long long)points[i][0] * 40001LL + points[i][1];
    }

    qsort(pointKeys, pointsSize, sizeof(long long), compareLongLong);

    int minArea = 0;

    for (int i = 0; i < pointsSize; ++i) {
        for (int j = i + 1; j < pointsSize; ++j) {
            int x1 = points[i][0];
            int y1 = points[i][1];
            int x2 = points[j][0];
            int y2 = points[j][1];

            if (x1 == x2 || y1 == y2) {
                continue;
            }

            long long key3 = (long long)x1 * 40001LL + y2;
            long long key4 = (long long)x2 * 40001LL + y1;

            void* found3 = bsearch(&key3, pointKeys, pointsSize, sizeof(long long), compareLongLong);
            void* found4 = bsearch(&key4, pointKeys, pointsSize, sizeof(long long), compareLongLong);

            if (found3 != NULL && found4 != NULL) {
                int currentArea = abs(x1 - x2) * abs(y1 - y2);

                if (minArea == 0 || currentArea < minArea) {
                    minArea = currentArea;
                }
            }
        }
    }

    free(pointKeys);
    return minArea;
}