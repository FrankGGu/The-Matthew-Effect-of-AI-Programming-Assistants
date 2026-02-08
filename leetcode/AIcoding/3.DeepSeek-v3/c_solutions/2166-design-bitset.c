typedef struct {
    char* bits;
    char* flipped;
    int size;
    int ones;
    int flip_flag;
} Bitset;

Bitset* bitsetCreate(int size) {
    Bitset* obj = (Bitset*)malloc(sizeof(Bitset));
    obj->bits = (char*)malloc(size + 1);
    obj->flipped = (char*)malloc(size + 1);
    obj->size = size;
    obj->ones = 0;
    obj->flip_flag = 0;

    for (int i = 0; i < size; i++) {
        obj->bits[i] = '0';
        obj->flipped[i] = '1';
    }
    obj->bits[size] = '\0';
    obj->flipped[size] = '\0';

    return obj;
}

void bitsetFix(Bitset* obj, int idx) {
    if (obj->flip_flag == 0) {
        if (obj->bits[idx] == '0') {
            obj->bits[idx] = '1';
            obj->ones++;
        }
    } else {
        if (obj->flipped[idx] == '0') {
            obj->flipped[idx] = '1';
            obj->ones++;
        }
    }
}

void bitsetUnfix(Bitset* obj, int idx) {
    if (obj->flip_flag == 0) {
        if (obj->bits[idx] == '1') {
            obj->bits[idx] = '0';
            obj->ones--;
        }
    } else {
        if (obj->flipped[idx] == '1') {
            obj->flipped[idx] = '0';
            obj->ones--;
        }
    }
}

void bitsetFlip(Bitset* obj) {
    obj->flip_flag = 1 - obj->flip_flag;
    obj->ones = obj->size - obj->ones;
}

bool bitsetAll(Bitset* obj) {
    return obj->ones == obj->size;
}

bool bitsetOne(Bitset* obj) {
    return obj->ones > 0;
}

int bitsetCount(Bitset* obj) {
    return obj->ones;
}

char* bitsetToString(Bitset* obj) {
    if (obj->flip_flag == 0) {
        return obj->bits;
    } else {
        return obj->flipped;
    }
}

void bitsetFree(Bitset* obj) {
    free(obj->bits);
    free(obj->flipped);
    free(obj);
}