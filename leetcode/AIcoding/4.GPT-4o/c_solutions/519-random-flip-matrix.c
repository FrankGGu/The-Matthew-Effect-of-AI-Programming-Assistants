typedef struct {
    int m;
    int n;
    int total;
    int *map;
} Solution;

Solution* solutionCreate(int nRows, int nCols) {
    Solution *obj = (Solution *)malloc(sizeof(Solution));
    obj->m = nRows;
    obj->n = nCols;
    obj->total = nRows * nCols;
    obj->map = (int *)malloc(sizeof(int) * obj->total);
    for (int i = 0; i < obj->total; i++) {
        obj->map[i] = i;
    }
    return obj;
}

int* solutionFlip(Solution* obj) {
    int idx = rand() % obj->total;
    int *res = (int *)malloc(sizeof(int) * 2);
    res[0] = obj->map[idx] / obj->n;
    res[1] = obj->map[idx] % obj->n;
    obj->map[idx] = obj->map[--obj->total];
    return res;
}

void solutionReset(Solution* obj) {
    obj->total = obj->m * obj->n;
}

void solutionFree(Solution* obj) {
    free(obj->map);
    free(obj);
}