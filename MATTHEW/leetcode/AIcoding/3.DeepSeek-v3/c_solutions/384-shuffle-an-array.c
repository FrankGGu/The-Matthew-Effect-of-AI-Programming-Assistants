#include <stdlib.h>
#include <string.h>

typedef struct {
    int* original;
    int* array;
    int size;
} Solution;

Solution* solutionCreate(int* nums, int numsSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->original = (int*)malloc(numsSize * sizeof(int));
    obj->array = (int*)malloc(numsSize * sizeof(int));
    obj->size = numsSize;
    memcpy(obj->original, nums, numsSize * sizeof(int));
    memcpy(obj->array, nums, numsSize * sizeof(int));
    return obj;
}

int* solutionReset(Solution* obj, int* retSize) {
    *retSize = obj->size;
    memcpy(obj->array, obj->original, obj->size * sizeof(int));
    return obj->array;
}

int* solutionShuffle(Solution* obj, int* retSize) {
    *retSize = obj->size;
    memcpy(obj->array, obj->original, obj->size * sizeof(int));
    for (int i = 0; i < obj->size; i++) {
        int j = rand() % (obj->size - i) + i;
        int temp = obj->array[i];
        obj->array[i] = obj->array[j];
        obj->array[j] = temp;
    }
    return obj->array;
}

void solutionFree(Solution* obj) {
    free(obj->original);
    free(obj->array);
    free(obj);
}