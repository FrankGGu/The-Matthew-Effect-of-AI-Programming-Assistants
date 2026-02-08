#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *arr;
    int size;
} RangeFreqQuery;

RangeFreqQuery* rangeFreqQueryCreate(int* arr, int arrSize) {
    RangeFreqQuery* obj = (RangeFreqQuery*)malloc(sizeof(RangeFreqQuery));
    obj->arr = arr;
    obj->size = arrSize;
    return obj;
}

int rangeFreqQueryQuery(RangeFreqQuery* obj, int left, int right, int value) {
    int count = 0;
    for (int i = left; i <= right; i++) {
        if (obj->arr[i] == value) {
            count++;
        }
    }
    return count;
}

void rangeFreqQueryFree(RangeFreqQuery* obj) {
    free(obj);
}