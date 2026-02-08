#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Interval {
    int start;
    int end;
};

struct Interval* intervalIntersection(struct Interval* A, int ASize, struct Interval* B, int BSize, int* returnSize) {
    int i = 0, j = 0, k = 0;
    struct Interval* result = (struct Interval*)malloc(sizeof(struct Interval) * (ASize + BSize));
    *returnSize = 0;

    while (i < ASize && j < BSize) {
        int start = (A[i].start > B[j].start) ? A[i].start : B[j].start;
        int end = (A[i].end < B[j].end) ? A[i].end : B[j].end;

        if (start <= end) {
            result[k].start = start;
            result[k].end = end;
            k++;
            (*returnSize)++;
        }

        if (A[i].end < B[j].end) {
            i++;
        } else {
            j++;
        }
    }

    struct Interval* finalResult = (struct Interval*)malloc(sizeof(struct Interval) * (*returnSize));
    for(int l = 0; l < *returnSize; l++){
        finalResult[l] = result[l];
    }
    free(result);
    return finalResult;
}