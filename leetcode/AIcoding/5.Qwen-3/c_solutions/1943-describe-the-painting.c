#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int start;
    int end;
    int color;
} Interval;

typedef struct {
    int key;
    int value;
} Pair;

int compare(const void *a, const void *b) {
    return ((Interval *)a)->start - ((Interval *)b)->start;
}

int comparePair(const void *a, const void *b) {
    return ((Pair *)a)->key - ((Pair *)b)->key;
}

int** describeThePainting(int** intervals, int intervalsSize, int* intervalsColSize, int* returnSize, int** returnColumnSizes) {
    int n = intervalsSize;
    Interval *sorted = (Interval *)malloc(n * sizeof(Interval));
    for (int i = 0; i < n; i++) {
        sorted[i].start = intervals[i][0];
        sorted[i].end = intervals[i][1];
        sorted[i].color = intervals[i][2];
    }
    qsort(sorted, n, sizeof(Interval), compare);

    int maxTime = 0;
    for (int i = 0; i < n; i++) {
        if (sorted[i].end > maxTime) {
            maxTime = sorted[i].end;
        }
    }

    Pair *timeline = (Pair *)calloc(maxTime + 2, sizeof(Pair));
    for (int i = 0; i < n; i++) {
        int start = sorted[i].start;
        int end = sorted[i].end;
        int color = sorted[i].color;
        timeline[start].key += color;
        timeline[end].key -= color;
    }

    int currentColor = 0;
    int prevTime = 0;
    int resultSize = 0;
    int **result = NULL;
    *returnColumnSizes = NULL;

    for (int t = 0; t <= maxTime; t++) {
        if (t > 0 && currentColor != 0) {
            result = (int **)realloc(result, (resultSize + 1) * sizeof(int *));
            (*returnColumnSizes) = (int *)realloc(*returnColumnSizes, (resultSize + 1) * sizeof(int));
            result[resultSize] = (int *)malloc(3 * sizeof(int));
            result[resultSize][0] = prevTime;
            result[resultSize][1] = t;
            result[resultSize][2] = currentColor;
            (*returnColumnSizes)[resultSize] = 3;
            resultSize++;
        }
        currentColor += timeline[t].key;
        prevTime = t;
    }

    *returnSize = resultSize;
    free(timeline);
    free(sorted);
    return result;
}