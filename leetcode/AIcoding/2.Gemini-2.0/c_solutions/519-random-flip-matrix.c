#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int n_rows;
    int n_cols;
    int total;
    int *map;
} Solution;

Solution* solutionCreate(int n_rows, int n_cols) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->n_rows = n_rows;
    obj->n_cols = n_cols;
    obj->total = n_rows * n_cols;
    obj->map = (int*)malloc(sizeof(int) * (n_rows * n_cols));
    for (int i = 0; i < n_rows * n_cols; i++) {
        obj->map[i] = i;
    }
    return obj;
}

int* solutionFlip(Solution* obj, int* retSize) {
    int rand_index = rand() % obj->total;
    int val = obj->map[rand_index];

    obj->map[rand_index] = obj->map[obj->total - 1];
    obj->map[obj->total - 1] = val;

    obj->total--;

    int row = val / obj->n_cols;
    int col = val % obj->n_cols;

    int* result = (int*)malloc(sizeof(int) * 2);
    result[0] = row;
    result[1] = col;
    *retSize = 2;
    return result;
}

void solutionReset(Solution* obj) {
    obj->total = obj->n_rows * obj->n_cols;
    for (int i = 0; i < obj->n_rows * obj->n_cols; i++) {
        obj->map[i] = i;
    }
}

void solutionFree(Solution* obj) {
    free(obj->map);
    free(obj);
}