#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
    int n;
    int m;
    int total;
    int count;
    int* used;
} Solution;

Solution* solutionCreate(int n, int m) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->n = n;
    obj->m = m;
    obj->total = n * m;
    obj->count = 0;
    obj->used = (int*)malloc(sizeof(int) * (obj->total + 1));
    return obj;
}

int solutionFlip(Solution* obj) {
    int rand_val;
    do {
        rand_val = rand() % obj->total;
    } while (obj->used[rand_val] == 1);
    obj->used[rand_val] = 1;
    obj->count++;
    return rand_val;
}

void solutionFree(Solution* obj) {
    free(obj->used);
    free(obj);
}