#include <stdlib.h> // For malloc, free

typedef struct {
    int* arr;
    int size;
} NeighborSumService;

NeighborSumService* neighborSumServiceCreate(int* nums, int numsSize) {
    NeighborSumService* obj = (NeighborSumService*)malloc(sizeof(NeighborSumService));
    obj->size = numsSize;
    obj->arr = (int*)malloc(sizeof(int) * numsSize);
    for (int i = 0; i < numsSize; i++) {
        obj->arr[i] = nums[i];
    }
    return obj;
}

void neighborSumServiceUpdate(NeighborSumService* obj, int index, int val) {
    obj->arr[index] = val;
}

long long neighborSumServiceQuery(NeighborSumService* obj, int index) {
    long long sum = 0;
    if (index > 0) {
        sum += obj->arr[index - 1];
    }
    sum += obj->arr[index];
    if (index < obj->size - 1) {
        sum += obj->arr[index + 1];
    }
    return sum;
}

void neighborSumServiceFree(NeighborSumService* obj) {
    free(obj->arr);
    free(obj);
}