#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int size;
    int index;
} DataStream;

DataStream* dataStreamCreate(int* nums, int numsSize) {
    DataStream* obj = (DataStream*)malloc(sizeof(DataStream));
    obj->data = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        obj->data[i] = nums[i];
    }
    obj->size = numsSize;
    obj->index = 0;
    return obj;
}

int dataStreamConsecutive(int dataStream, int k) {
    DataStream* obj = (DataStream*)dataStream;
    if (obj->index + k > obj->size) {
        return 0;
    }
    for (int i = 0; i < k - 1; i++) {
        if (obj->data[obj->index + i + 1] != obj->data[obj->index + i] + 1) {
            return 0;
        }
    }
    obj->index++;
    return 1;
}

void dataStreamFree(DataStream* obj) {
    free(obj->data);
    free(obj);
}