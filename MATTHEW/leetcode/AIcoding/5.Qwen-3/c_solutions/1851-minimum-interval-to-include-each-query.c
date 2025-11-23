#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    int* data;
    int size;
    int capacity;
} Vector;

Vector* create_vector(int capacity) {
    Vector* vec = (Vector*)malloc(sizeof(Vector));
    vec->data = (int*)malloc(capacity * sizeof(int));
    vec->size = 0;
    vec->capacity = capacity;
    return vec;
}

void push_vector(Vector* vec, int value) {
    if (vec->size == vec->capacity) {
        vec->capacity *= 2;
        vec->data = (int*)realloc(vec->data, vec->capacity * sizeof(int));
    }
    vec->data[vec->size++] = value;
}

void free_vector(Vector* vec) {
    free(vec->data);
    free(vec);
}

int compare_intervals(const void* a, const void* b) {
    const Interval* intervalA = (const Interval*)a;
    const Interval* intervalB = (const Interval*)b;
    return intervalA->start - intervalB->start;
}

int compare_queries(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int* minInterval(int** intervals, int intervalsSize, int* queries, int queriesSize, int* returnSize) {
    qsort(intervals, intervalsSize, sizeof(Interval), compare_intervals);

    int* sortedQueries = (int*)malloc(queriesSize * sizeof(int));
    memcpy(sortedQueries, queries, queriesSize * sizeof(int));
    qsort(sortedQueries, queriesSize, sizeof(int), compare_queries);

    int* result = (int*)malloc(queriesSize * sizeof(int));
    int* indexMap = (int*)malloc(queriesSize * sizeof(int));

    for (int i = 0; i < queriesSize; i++) {
        indexMap[i] = i;
    }

    qsort(indexMap, queriesSize, sizeof(int), (int(*)(const void*, const void*))compare_queries);

    int j = 0;
    int minHeapSize = 0;
    int* heap = (int*)malloc(intervalsSize * sizeof(int));
    int* heapEnd = heap;

    for (int i = 0; i < queriesSize; i++) {
        int query = sortedQueries[i];

        while (j < intervalsSize && intervals[j].start <= query) {
            int intervalLength = intervals[j].end - intervals[j].start + 1;
            *heapEnd++ = intervalLength;
            j++;
        }

        while (heapEnd > heap && *heap <= query) {
            memmove(heap, heap + 1, (heapEnd - heap - 1) * sizeof(int));
            heapEnd--;
        }

        if (heapEnd > heap) {
            result[indexMap[i]] = *heap;
        } else {
            result[indexMap[i]] = -1;
        }
    }

    free(sortedQueries);
    free(indexMap);
    free(heap);
    *returnSize = queriesSize;
    return result;
}