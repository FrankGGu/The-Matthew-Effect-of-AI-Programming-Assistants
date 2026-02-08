typedef struct {
    int *A;
    int n;
    int index;
    int count;
} RLEIterator;

RLEIterator* rLEIteratorCreate(int* A, int ASize) {
    RLEIterator* obj = (RLEIterator*)malloc(sizeof(RLEIterator));
    obj->A = A;
    obj->n = ASize;
    obj->index = 0;
    obj->count = 0;
    return obj;
}

int rLEIteratorNext(RLEIterator* obj, int n) {
    while (obj->index < obj->n) {
        if (obj->count + n <= obj->A[obj->index]) {
            obj->count += n;
            return obj->A[obj->index + 1];
        }
        n -= (obj->A[obj->index] - obj->count);
        obj->index += 2;
        obj->count = 0;
    }
    return -1;
}

void rLEIteratorFree(RLEIterator* obj) {
    free(obj);
}