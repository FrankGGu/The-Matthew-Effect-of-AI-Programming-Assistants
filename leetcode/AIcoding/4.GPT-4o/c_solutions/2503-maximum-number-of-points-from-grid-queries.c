#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x, y, idx;
} Query;

int cmp(const void *a, const void *b) {
    return ((Query *)a)->y - ((Query *)b)->y;
}

int maxPoints(int** points, int pointsSize, int* pointsColSize, int** queries, int queriesSize, int* queriesColSize) {
    int* result = (int*)malloc(sizeof(int) * queriesSize);
    Query* q = (Query*)malloc(sizeof(Query) * queriesSize);
    int* prefixSum = (int*)malloc(sizeof(int) * (pointsSize + 1));

    for (int i = 0; i < queriesSize; i++) {
        q[i].x = queries[i][0];
        q[i].y = queries[i][1];
        q[i].idx = i;
    }

    qsort(q, queriesSize, sizeof(Query), cmp);

    int j = 0;
    for (int i = 0; i < queriesSize; i++) {
        while (j < pointsSize && points[j][1] <= q[i].y) {
            prefixSum[j + 1] = prefixSum[j] + 1;
            j++;
        }
        result[q[i].idx] = prefixSum[j];
    }

    free(q);
    free(prefixSum);
    return result;
}