#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* map;
    int size;
    int n;
} Solution;

Solution* solutionCreate(int n, int* blacklist, int blacklistSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->n = n;
    obj->size = n - blacklistSize;
    obj->map = (int*)malloc(obj->size * sizeof(int));
    int* black = (int*)malloc(blacklistSize * sizeof(int));
    for (int i = 0; i < blacklistSize; i++) {
        black[i] = blacklist[i];
    }
    qsort(black, blacklistSize, sizeof(int), (int (*)(const void*, const void*))strcmp);
    int last = n - 1;
    int index = 0;
    for (int i = 0; i < blacklistSize; i++) {
        if (black[i] < last) {
            obj->map[index++] = black[i];
            obj->map[index++] = last--;
        }
    }
    free(black);
    return obj;
}

int solutionPick(Solution* obj) {
    int x = rand() % obj->size;
    return obj->map[x];
}

void solutionFree(Solution* obj) {
    free(obj->map);
    free(obj);
}