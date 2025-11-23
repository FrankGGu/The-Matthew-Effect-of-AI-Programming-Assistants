#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* indices;
    int size;
} FrequencyMap;

typedef struct {
    FrequencyMap** map;
    int n;
} RangeFrequencyQuery;

RangeFrequencyQuery* rangeFrequencyQueryCreate(char* s, int sSize) {
    RangeFrequencyQuery* obj = (RangeFrequencyQuery*)malloc(sizeof(RangeFrequencyQuery));
    obj->n = sSize;
    obj->map = (FrequencyMap*)calloc(256, sizeof(FrequencyMap));

    for (int i = 0; i < 256; i++) {
        obj->map[i].indices = NULL;
        obj->map[i].size = 0;
    }

    for (int i = 0; i < sSize; i++) {
        char c = s[i];
        int idx = (int)c;
        obj->map[idx].size++;
        obj->map[idx].indices = (int*)realloc(obj->map[idx].indices, obj->map[idx].size * sizeof(int));
        obj->map[idx].indices[obj->map[idx].size - 1] = i;
    }

    return obj;
}

int rangeFrequencyQueryGet(int l, int r, int k, RangeFrequencyQuery* obj) {
    char c = (char)k;
    int idx = (int)c;
    FrequencyMap* fm = &obj->map[idx];

    if (fm->size == 0) return 0;

    int* arr = fm->indices;
    int left = 0, right = fm->size - 1;
    int first = -1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] >= l) {
            first = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    if (first == -1) return 0;

    left = 0;
    right = fm->size - 1;
    int last = -1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] <= r) {
            last = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return last - first + 1;
}

void rangeFrequencyQueryFree(RangeFrequencyQuery* obj) {
    for (int i = 0; i < 256; i++) {
        free(obj->map[i].indices);
    }
    free(obj->map);
    free(obj);
}