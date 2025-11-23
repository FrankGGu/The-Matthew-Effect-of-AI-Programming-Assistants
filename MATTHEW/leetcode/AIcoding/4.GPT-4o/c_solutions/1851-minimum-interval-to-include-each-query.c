#include <stdlib.h>

typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    int index;
    int value;
} Query;

int compareIntervals(const void *a, const void *b) {
    Interval *ia = (Interval *)a;
    Interval *ib = (Interval *)b;
    return ia->start - ib->start;
}

int compareQueries(const void *a, const void *b) {
    Query *qa = (Query *)a;
    Query *qb = (Query *)b;
    return qa->value - qb->value;
}

int* minInterval(int** intervals, int intervalsSize, int* intervalsColSize, int* queries, int queriesSize, int* returnSize) {
    Interval* intervalArr = (Interval*)malloc(intervalsSize * sizeof(Interval));
    for (int i = 0; i < intervalsSize; i++) {
        intervalArr[i].start = intervals[i][0];
        intervalArr[i].end = intervals[i][1];
    }

    Query* queryArr = (Query*)malloc(queriesSize * sizeof(Query));
    for (int i = 0; i < queriesSize; i++) {
        queryArr[i].index = i;
        queryArr[i].value = queries[i];
    }

    qsort(intervalArr, intervalsSize, sizeof(Interval), compareIntervals);
    qsort(queryArr, queriesSize, sizeof(Query), compareQueries);

    int* result = (int*)malloc(queriesSize * sizeof(int));
    int* minHeap = (int*)malloc(intervalsSize * sizeof(int));
    int heapSize = 0;
    int intervalIndex = 0;

    for (int i = 0; i < queriesSize; i++) {
        while (intervalIndex < intervalsSize && intervalArr[intervalIndex].start <= queryArr[i].value) {
            minHeap[heapSize++] = intervalArr[intervalIndex].end;
            intervalIndex++;
        }
        while (heapSize > 0 && minHeap[0] < queryArr[i].value) {
            heapSize--;
            for (int j = 0; j < heapSize; j++) {
                minHeap[j] = minHeap[j + 1];
            }
        }
        if (heapSize > 0) {
            result[queryArr[i].index] = minHeap[0] - queryArr[i].value + 1;
        } else {
            result[queryArr[i].index] = -1;
        }
    }

    free(intervalArr);
    free(queryArr);
    free(minHeap);
    *returnSize = queriesSize;
    return result;
}