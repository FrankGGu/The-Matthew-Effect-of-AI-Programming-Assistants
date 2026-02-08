#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* start;
    int* end;
    int size;
} RangeModule;

RangeModule* rangeModuleCreate() {
    RangeModule* obj = (RangeModule*)malloc(sizeof(RangeModule));
    obj->start = NULL;
    obj->end = NULL;
    obj->size = 0;
    return obj;
}

void rangeModuleAddRange(RangeModule* obj, int left, int right) {
    int* new_start = (int*)malloc((obj->size + 1) * sizeof(int));
    int* new_end = (int*)malloc((obj->size + 1) * sizeof(int));
    int i, j = 0;
    int new_left = left, new_right = right;
    int merged = 0;

    for (i = 0; i < obj->size; i++) {
        if (obj->end[i] < left - 1) {
            new_start[j] = obj->start[i];
            new_end[j++] = obj->end[i];
        } else if (obj->start[i] > right + 1) {
            if (!merged) {
                new_start[j++] = new_left;
                new_end[j++] = new_right;
                merged = 1;
            }
            new_start[j] = obj->start[i];
            new_end[j++] = obj->end[i];
        } else {
            new_left = (new_left < obj->start[i]) ? new_left : obj->start[i];
            new_right = (new_right > obj->end[i]) ? new_right : obj->end[i];
        }
    }

    if (!merged) {
        new_start[j++] = new_left;
        new_end[j++] = new_right;
    }

    free(obj->start);
    free(obj->end);
    obj->start = new_start;
    obj->end = new_end;
    obj->size = j;
}

int rangeModuleQueryRange(RangeModule* obj, int left, int right) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->start[i] <= left && obj->end[i] >= right) {
            return 1;
        }
    }
    return 0;
}

void rangeModuleRemoveRange(RangeModule* obj, int left, int right) {
    int* new_start = (int*)malloc(obj->size * sizeof(int));
    int* new_end = (int*)malloc(obj->size * sizeof(int));
    int j = 0;

    for (int i = 0; i < obj->size; i++) {
        if (obj->end[i] < left || obj->start[i] > right) {
            new_start[j] = obj->start[i];
            new_end[j++] = obj->end[i];
        } else {
            if (obj->start[i] < left) {
                new_start[j] = obj->start[i];
                new_end[j++] = left - 1;
            }
            if (obj->end[i] > right) {
                new_start[j] = right + 1;
                new_end[j++] = obj->end[i];
            }
        }
    }

    free(obj->start);
    free(obj->end);
    obj->start = new_start;
    obj->end = new_end;
    obj->size = j;
}

void rangeModuleFree(RangeModule* obj) {
    free(obj->start);
    free(obj->end);
    free(obj);
}