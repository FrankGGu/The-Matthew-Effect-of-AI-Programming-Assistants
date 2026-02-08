#include <stdlib.h>
#include <time.h>
#include <string.h>

typedef struct {
    int* original;
    int* current;
    int size;
} Solution;

Solution* solutionCreate(int* nums, int numsSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->size = numsSize;
    obj->original = (int*)malloc(sizeof(int) * numsSize);
    obj->current = (int*)malloc(sizeof(int) * numsSize);

    memcpy(obj->original, nums, sizeof(int) * numsSize);
    memcpy(obj->current, nums, sizeof(int) * numsSize);

    srand(time(NULL));
    return obj;
}

int* solutionReset(Solution* obj) {
    memcpy(obj->current, obj->original, sizeof(int) * obj->size);
    return obj->current;
}

int* solutionShuffle(Solution* obj) {
    for (int i = 0; i < obj->size; i++) {
        int r = i + (rand() % (obj->size - i));
        int temp = obj->current[i];
        obj->current[i] = obj->current[r];
        obj->current[r] = temp;
    }
    return obj->current;
}

void solutionFree(Solution* obj) {
    free(obj->original);
    free(obj->current);
    free(obj);
}