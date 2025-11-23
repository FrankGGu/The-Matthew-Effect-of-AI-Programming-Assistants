typedef struct {
    int capacity;
    int *stacks;
    int *tops;
    int totalStacks;
    int leftmost;
    int rightmost;
} DinnerPlates;

DinnerPlates* dinnerPlatesCreate(int capacity) {
    DinnerPlates *obj = (DinnerPlates*)malloc(sizeof(DinnerPlates));
    obj->capacity = capacity;
    obj->totalStacks = 200000;
    obj->stacks = (int*)malloc(sizeof(int) * obj->totalStacks * capacity);
    obj->tops = (int*)malloc(sizeof(int) * obj->totalStacks);
    for (int i = 0; i < obj->totalStacks; i++) {
        obj->tops[i] = -1;
    }
    obj->leftmost = 0;
    obj->rightmost = 0;
    return obj;
}

void dinnerPlatesPush(DinnerPlates* obj, int val) {
    while (obj->leftmost < obj->totalStacks && obj->tops[obj->leftmost] == obj->capacity - 1) {
        obj->leftmost++;
    }
    if (obj->leftmost >= obj->totalStacks) {
        return;
    }
    obj->tops[obj->leftmost]++;
    obj->stacks[obj->leftmost * obj->capacity + obj->tops[obj->leftmost]] = val;
    if (obj->leftmost > obj->rightmost) {
        obj->rightmost = obj->leftmost;
    }
}

int dinnerPlatesPop(DinnerPlates* obj) {
    while (obj->rightmost >= 0 && obj->tops[obj->rightmost] == -1) {
        obj->rightmost--;
    }
    if (obj->rightmost < 0) {
        return -1;
    }
    int val = obj->stacks[obj->rightmost * obj->capacity + obj->tops[obj->rightmost]];
    obj->tops[obj->rightmost]--;
    return val;
}

int dinnerPlatesPopAtStack(DinnerPlates* obj, int index) {
    if (index < 0 || index >= obj->totalStacks || obj->tops[index] == -1) {
        return -1;
    }
    int val = obj->stacks[index * obj->capacity + obj->tops[index]];
    obj->tops[index]--;
    if (index < obj->leftmost) {
        obj->leftmost = index;
    }
    return val;
}

void dinnerPlatesFree(DinnerPlates* obj) {
    free(obj->stacks);
    free(obj->tops);
    free(obj);
}

/**
 * Your DinnerPlates struct will be instantiated and called as such:
 * DinnerPlates* obj = dinnerPlatesCreate(capacity);
 * dinnerPlatesPush(obj, val);

 * int param_2 = dinnerPlatesPop(obj);

 * int param_3 = dinnerPlatesPopAtStack(obj, index);

 * dinnerPlatesFree(obj);
*/