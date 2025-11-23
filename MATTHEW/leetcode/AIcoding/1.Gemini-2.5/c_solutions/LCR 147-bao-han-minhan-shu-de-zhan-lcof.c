#include <stdlib.h>

#define INITIAL_CAPACITY 100

typedef struct {
    int* data;
    int dataTop;
    int dataCapacity;

    int* minData;
    int minTop;
    int minCapacity;
} MinStack;

MinStack* minStackCreate() {
    MinStack* obj = (MinStack*) malloc(sizeof(MinStack));
    if (!obj) return NULL;

    obj->dataCapacity = INITIAL_CAPACITY;
    obj->data = (int*) malloc(sizeof(int) * obj->dataCapacity);
    if (!obj->data) {
        free(obj);
        return NULL;
    }
    obj->dataTop = -1;

    obj->minCapacity = INITIAL_CAPACITY;
    obj->minData = (int*) malloc(sizeof(int) * obj->minCapacity);
    if (!obj->minData) {
        free(obj->data);
        free(obj);
        return NULL;
    }
    obj->minTop = -1;

    return obj;
}

void minStackPush(MinStack* obj, int x) {
    if (obj->dataTop + 1 == obj->dataCapacity) {
        obj->dataCapacity *= 2;
        int* newData = (int*) realloc(obj->data, sizeof(int) * obj->dataCapacity);
        if (!newData) return;
        obj->data = newData;
    }

    obj->data[++obj->dataTop] = x;

    if (obj->minTop == -1 || x <= obj->minData[obj->minTop]) {
        if (obj->minTop + 1 == obj->minCapacity) {
            obj->minCapacity *= 2;
            int* newMinData = (int*) realloc(obj->minData, sizeof(int) * obj->minCapacity);
            if (!newMinData) return;
            obj->minData = newMinData;
        }
        obj->minData[++obj->minTop] = x;
    }
}

void minStackPop(MinStack* obj) {
    int poppedVal = obj->data[obj->dataTop--];

    if (poppedVal == obj->minData[obj->minTop]) {
        obj->minTop--;
    }
}

int minStackTop(MinStack* obj) {
    return obj->data[obj->dataTop];
}

int minStackGetMin(MinStack* obj) {
    return obj->minData[obj->minTop];
}

void minStackFree(MinStack* obj) {
    free(obj->data);
    free(obj->minData);
    free(obj);
}