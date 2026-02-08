typedef struct {
    int sum;
} Accumulator;

Accumulator* accumulatorCreate() {
    Accumulator* obj = (Accumulator*)malloc(sizeof(Accumulator));
    obj->sum = 0;
    return obj;
}

void accumulatorAdd(Accumulator* obj, int x) {
    obj->sum += x;
}

int accumulatorGet(Accumulator* obj) {
    return obj->sum;
}

void accumulatorFree(Accumulator* obj) {
    free(obj);
}

/**
 * Your Accumulator struct will be instantiated and called as such:
 * Accumulator* obj = accumulatorCreate();
 * accumulatorAdd(obj, x);

 * int param_2 = accumulatorGet(obj);

 * accumulatorFree(obj);
*/