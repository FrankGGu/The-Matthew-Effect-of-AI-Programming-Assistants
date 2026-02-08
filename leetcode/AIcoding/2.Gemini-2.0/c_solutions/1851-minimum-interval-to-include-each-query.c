#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
    int index;
} Query;

int compareIntervals(const void *a, const void *b) {
    return ((int*)a)[0] - ((int*)b)[0];
}

int compareQueries(const void *a, const void *b) {
    return ((Query*)a)->start - ((Query*)b)->start;
}

int* minInterval(int** intervals, int intervalsSize, int* intervalsColSize, int* queries, int queriesSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    qsort(intervals, intervalsSize, sizeof(intervals[0]), compareIntervals);

    Query* sortedQueries = (Query*)malloc(queriesSize * sizeof(Query));
    for (int i = 0; i < queriesSize; i++) {
        sortedQueries[i].start = queries[i];
        sortedQueries[i].index = i;
    }

    qsort(sortedQueries, queriesSize, sizeof(Query), compareQueries);

    int* heap = (int*)malloc(intervalsSize * 2 * sizeof(int)); 
    int heapSize = 0;
    int intervalsIndex = 0;

    for (int i = 0; i < queriesSize; i++) {
        int queryValue = sortedQueries[i].start;

        while (intervalsIndex < intervalsSize && intervals[intervalsIndex][0] <= queryValue) {
            heap[heapSize * 2] = intervals[intervalsIndex][1] - intervals[intervalsIndex][0] + 1; 
            heap[heapSize * 2 + 1] = intervals[intervalsIndex][1]; 
            heapSize++;
            intervalsIndex++;
        }

        int minIntervalSize = -1;
        int minIntervalEnd = -1;
        int minIndex = -1;

        for(int j = 0; j < heapSize; j++) {
            if(intervalsIndex > 0 && intervals[intervalsIndex-1][0] <= queryValue) {
                if(heap[j*2+1] >= queryValue) {
                   if (minIntervalSize == -1 || heap[j*2] < minIntervalSize) {
                        minIntervalSize = heap[j*2];
                        minIntervalEnd = heap[j*2+1];
                   }
                }
            }
        }

        result[sortedQueries[i].index] = minIntervalSize;
    }

    free(heap);
    free(sortedQueries);

    return result;
}