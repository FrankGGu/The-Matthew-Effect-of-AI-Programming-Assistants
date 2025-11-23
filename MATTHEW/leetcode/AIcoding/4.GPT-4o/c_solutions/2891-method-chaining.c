typedef struct {
    int value;
} Chaining;

Chaining* chainingCreate() {
    Chaining* obj = malloc(sizeof(Chaining));
    obj->value = 0;
    return obj;
}

Chaining* chainingAdd(Chaining* obj, int num) {
    obj->value += num;
    return obj;
}

Chaining* chainingSubtract(Chaining* obj, int num) {
    obj->value -= num;
    return obj;
}

Chaining* chainingMultiply(Chaining* obj, int num) {
    obj->value *= num;
    return obj;
}

int chainingGetValue(Chaining* obj) {
    return obj->value;
}

void chainingFree(Chaining* obj) {
    free(obj);
}