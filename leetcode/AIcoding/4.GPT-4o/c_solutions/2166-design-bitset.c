typedef struct {
    int size;
    unsigned char *bits;
    int flipped;
} Bitset;

Bitset* bitsetCreate(int size) {
    Bitset *bitset = (Bitset *)malloc(sizeof(Bitset));
    bitset->size = size;
    bitset->bits = (unsigned char *)calloc((size + 7) / 8, sizeof(unsigned char));
    bitset->flipped = 0;
    return bitset;
}

void bitsetFix(Bitset* obj, int idx) {
    if (obj->flipped) {
        obj->bits[idx / 8] &= ~(1 << (idx % 8));
    } else {
        obj->bits[idx / 8] |= (1 << (idx % 8));
    }
}

void bitsetUnfix(Bitset* obj, int idx) {
    if (obj->flipped) {
        obj->bits[idx / 8] |= (1 << (idx % 8));
    } else {
        obj->bits[idx / 8] &= ~(1 << (idx % 8));
    }
}

bool bitsetTest(Bitset* obj, int idx) {
    if (obj->flipped) {
        return !(obj->bits[idx / 8] & (1 << (idx % 8)));
    } else {
        return (obj->bits[idx / 8] & (1 << (idx % 8))) != 0;
    }
}

void bitsetFlip(Bitset* obj) {
    obj->flipped = !obj->flipped;
}

int bitsetCount(Bitset* obj) {
    int count = 0;
    for (int i = 0; i < obj->size; i++) {
        if (bitsetTest(obj, i)) {
            count++;
        }
    }
    return obj->flipped ? obj->size - count : count;
}

char* bitsetToString(Bitset* obj) {
    char *str = (char *)malloc(obj->size + 1);
    for (int i = 0; i < obj->size; i++) {
        str[i] = bitsetTest(obj, i) ? '1' : '0';
    }
    str[obj->size] = '\0';
    return str;
}

void bitsetFree(Bitset* obj) {
    free(obj->bits);
    free(obj);
}