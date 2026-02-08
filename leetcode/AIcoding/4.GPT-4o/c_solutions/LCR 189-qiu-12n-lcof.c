typedef struct {
    int value;
} MechanicalAccumulator;

MechanicalAccumulator* constructor() {
    MechanicalAccumulator* accumulator = (MechanicalAccumulator*)malloc(sizeof(MechanicalAccumulator));
    accumulator->value = 0;
    return accumulator;
}

void add(MechanicalAccumulator* obj, int x) {
    obj->value += x;
}

int getValue(MechanicalAccumulator* obj) {
    return obj->value;
}

void freeMechanicalAccumulator(MechanicalAccumulator* obj) {
    free(obj);
}