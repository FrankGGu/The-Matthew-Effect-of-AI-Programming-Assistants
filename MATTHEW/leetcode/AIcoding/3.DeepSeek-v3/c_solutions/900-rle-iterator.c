typedef struct {
    int* encoding;
    int size;
    int index;
    int count;
} RLEIterator;

RLEIterator* rLEIteratorCreate(int* encoding, int encodingSize) {
    RLEIterator* obj = (RLEIterator*)malloc(sizeof(RLEIterator));
    obj->encoding = encoding;
    obj->size = encodingSize;
    obj->index = 0;
    obj->count = 0;
    return obj;
}

int rLEIteratorNext(RLEIterator* obj, int n) {
    while (obj->index < obj->size) {
        if (obj->count + n <= obj->encoding[obj->index]) {
            obj->count += n;
            return obj->encoding[obj->index + 1];
        } else {
            n -= (obj->encoding[obj->index] - obj->count);
            obj->count = 0;
            obj->index += 2;
        }
    }
    return -1;
}

void rLEIteratorFree(RLEIterator* obj) {
    free(obj);
}