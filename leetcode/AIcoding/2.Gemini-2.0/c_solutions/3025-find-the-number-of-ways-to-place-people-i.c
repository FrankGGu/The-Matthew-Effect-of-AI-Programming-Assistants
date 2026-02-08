#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    int *pa = (int *)a;
    int *pb = (int *)b;
    if (pa[0] != pb[0]) {
        return pa[0] - pb[0];
    } else {
        return pa[1] - pb[1];
    }
}

int numberOfWays(int** points, int pointsSize, int* pointsColSize) {
    qsort(points, pointsSize, sizeof(int) * 2, cmp);
    int count = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            if (points[j][1] >= points[i][1]) {
                int valid = 1;
                for (int k = 0; k < pointsSize; k++) {
                    if (k != i && k != j) {
                        if ((points[k][0] >= points[i][0] && points[k][0] <= points[j][0]) && (points[k][1] > points[i][1])) {
                            valid = 0;
                            break;
                        }
                    }
                }
                if (valid) {
                    count++;
                }
            }
        }
    }
    return count;
}