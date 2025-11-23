#include <stdlib.h>
#include <string.h>

typedef struct {
    int* encoding;
    int encoding_size;
    int current_pair_index;
} RLEIterator;

RLEIterator* rleIteratorCreate(int* encoding, int encodingSize) {
    RLEIterator* obj = (RLEIterator*) malloc(sizeof(RLEIterator));
    obj->encoding = (int*) malloc(sizeof(int) * encodingSize);
    memcpy(obj->encoding, encoding, sizeof(int) * encodingSize);
    obj->encoding_size = encodingSize;
    obj->current_pair_index = 0;
    return obj;
}

int rleIteratorNext(RLEIterator* obj, int n) {
    while (obj->current_pair_index < obj->encoding_size) {
        int current_count = obj->encoding[obj->current_pair_index];
        int current_value = obj->encoding[obj->current_pair_index + 1];

        if (n <= current_count) {
            obj->encoding[obj->current_pair_index] -= n;
            return current_value;
        } else {
            n -= current_count;
            obj->current_pair_index += 2;
        }
    }
    return -1;
}

void rleIteratorFree(RLEIterator* obj) {
    if (obj) {
        free(obj->encoding);
        free(obj);
    }
}