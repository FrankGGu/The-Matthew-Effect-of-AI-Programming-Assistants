#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *data;
    int head;
    int tail;
    int size;
    int capacity;
} MyCircularDeque;

MyCircularDeque* myCircularDequeCreate(int k) {
    MyCircularDeque* obj = (MyCircularDeque*)malloc(sizeof(MyCircularDeque));
    obj->data = (int*)malloc(sizeof(int) * k);
    obj->head = 0;
    obj->tail = 0;
    obj->size = 0;
    obj->capacity = k;
    return obj;
}

bool myCircularDequeInsertFront(MyCircularDeque* obj, int value) {
    if (obj->size == obj->capacity) {
        return false;
    }
    obj->head = (obj->head - 1 + obj->capacity) % obj->capacity;
    obj->data[obj->head] = value;
    obj->size++;
    return true;
}

bool myCircularDequeInsertLast(MyCircularDeque* obj, int value) {
    if (obj->size == obj->capacity) {
        return false;
    }
    obj->data[obj->tail] = value;
    obj->tail = (obj->tail + 1) % obj->capacity;
    obj->size++;
    return true;
}

bool myCircularDequeDeleteFront(MyCircularDeque* obj) {
    if (obj->size == 0) {
        return false;
    }
    obj->head = (obj->head + 1) % obj->capacity;
    obj->size--;
    return true;
}

bool myCircularDequeDeleteLast(MyCircularDeque* obj) {
    if (obj->size == 0) {
        return false;
    }
    obj->tail = (obj->tail - 1 + obj->capacity) % obj->capacity;
    obj->size--;
    return true;
}

int myCircularDequeGetFront(MyCircularDeque* obj) {
    if (obj->size == 0) {
        return -1;
    }
    return obj->data[obj->head];
}

int myCircularDequeGetRear(MyCircularDeque* obj) {
    if (obj->size == 0) {
        return -1;
    }
    return obj->data[(obj->tail - 1 + obj->capacity) % obj->capacity];
}

bool myCircularDequeIsEmpty(MyCircularDeque* obj) {
    return obj->size == 0;
}

bool myCircularDequeIsFull(MyCircularDeque* obj) {
    return obj->size == obj->capacity;
}

void myCircularDequeFree(MyCircularDeque* obj) {
    free(obj->data);
    free(obj);
}