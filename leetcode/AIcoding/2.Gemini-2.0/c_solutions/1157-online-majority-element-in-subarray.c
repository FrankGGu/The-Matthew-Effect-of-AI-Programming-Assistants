#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* arr;
    int size;
} MajorityChecker;

MajorityChecker* majorityCheckerCreate(int* arr, int arrSize) {
    MajorityChecker* obj = (MajorityChecker*)malloc(sizeof(MajorityChecker));
    obj->arr = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        obj->arr[i] = arr[i];
    }
    obj->size = arrSize;
    return obj;
}

int majorityCheckerQuery(MajorityChecker* obj, int left, int right, int threshold) {
    int len = right - left + 1;
    int candidate = -1;
    int count = 0;
    for (int i = left; i <= right; i++) {
        if (count == 0) {
            candidate = obj->arr[i];
            count = 1;
        } else if (obj->arr[i] == candidate) {
            count++;
        } else {
            count--;
        }
    }

    int freq = 0;
    for (int i = left; i <= right; i++) {
        if (obj->arr[i] == candidate) {
            freq++;
        }
    }

    if (freq >= threshold) {
        return candidate;
    } else {
        return -1;
    }
}

void majorityCheckerFree(MajorityChecker* obj) {
    free(obj->arr);
    free(obj);
}