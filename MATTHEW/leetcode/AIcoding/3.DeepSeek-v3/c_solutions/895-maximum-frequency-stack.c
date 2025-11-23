typedef struct {
    int val;
    int freq;
    int pushOrder;
} Element;

typedef struct {
    Element* elements;
    int capacity;
    int size;
    int pushCount;
    int maxFreq;
} FreqStack;

FreqStack* freqStackCreate() {
    FreqStack* obj = (FreqStack*)malloc(sizeof(FreqStack));
    obj->capacity = 10000;
    obj->size = 0;
    obj->pushCount = 0;
    obj->maxFreq = 0;
    obj->elements = (Element*)malloc(obj->capacity * sizeof(Element));
    return obj;
}

void freqStackPush(FreqStack* obj, int val) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->elements = (Element*)realloc(obj->elements, obj->capacity * sizeof(Element));
    }

    int found = -1;
    for (int i = 0; i < obj->size; i++) {
        if (obj->elements[i].val == val) {
            found = i;
            break;
        }
    }

    if (found != -1) {
        obj->elements[found].freq++;
        obj->elements[found].pushOrder = obj->pushCount++;
        if (obj->elements[found].freq > obj->maxFreq) {
            obj->maxFreq = obj->elements[found].freq;
        }
    } else {
        obj->elements[obj->size].val = val;
        obj->elements[obj->size].freq = 1;
        obj->elements[obj->size].pushOrder = obj->pushCount++;
        if (1 > obj->maxFreq) {
            obj->maxFreq = 1;
        }
        obj->size++;
    }
}

int freqStackPop(FreqStack* obj) {
    int maxFreq = obj->maxFreq;
    int latestPush = -1;
    int popIndex = -1;

    for (int i = 0; i < obj->size; i++) {
        if (obj->elements[i].freq == maxFreq && obj->elements[i].pushOrder > latestPush) {
            latestPush = obj->elements[i].pushOrder;
            popIndex = i;
        }
    }

    int result = obj->elements[popIndex].val;
    obj->elements[popIndex].freq--;

    if (obj->elements[popIndex].freq == 0) {
        for (int i = popIndex; i < obj->size - 1; i++) {
            obj->elements[i] = obj->elements[i + 1];
        }
        obj->size--;
    }

    obj->maxFreq = 0;
    for (int i = 0; i < obj->size; i++) {
        if (obj->elements[i].freq > obj->maxFreq) {
            obj->maxFreq = obj->elements[i].freq;
        }
    }

    return result;
}

void freqStackFree(FreqStack* obj) {
    free(obj->elements);
    free(obj);
}