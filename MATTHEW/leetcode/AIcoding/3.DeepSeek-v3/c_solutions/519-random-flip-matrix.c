#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int rows;
    int cols;
    int total;
    int used;
    int* map;
} Solution;

Solution* solutionCreate(int n_rows, int n_cols) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->rows = n_rows;
    obj->cols = n_cols;
    obj->total = n_rows * n_cols;
    obj->used = 0;
    obj->map = (int*)malloc(obj->total * sizeof(int));
    return obj;
}

int* solutionFlip(Solution* obj, int* retSize) {
    *retSize = 2;
    int* res = (int*)malloc(2 * sizeof(int));

    int idx = rand() % (obj->total - obj->used);

    int pos = idx;
    if (obj->map[idx] != 0) {
        pos = obj->map[idx] - 1;
    }

    int last_pos = obj->total - obj->used - 1;
    if (obj->map[last_pos] != 0) {
        obj->map[idx] = obj->map[last_pos];
    } else {
        obj->map[idx] = last_pos + 1;
    }

    res[0] = pos / obj->cols;
    res[1] = pos % obj->cols;

    obj->used++;

    return res;
}

void solutionReset(Solution* obj) {
    obj->used = 0;
}

void solutionFree(Solution* obj) {
    free(obj->map);
    free(obj);
}