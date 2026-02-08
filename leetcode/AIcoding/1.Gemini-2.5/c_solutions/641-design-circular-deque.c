#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int* arr;
    int front;
    int rear;
    int capacity;
    int count;
} MyCircularDeque;

MyCircularDeque* myCircularDequeCreate(int k) {
    MyCircularDeque* obj = (MyCircularDeque*)malloc(sizeof(MyCircularDeque));
    obj->arr = (int*)malloc(k * sizeof(int));
    obj->capacity = k;
    obj->front = 0;
    obj->rear = 0; // rear points to the next available slot for insertion
    obj->count = 0;
    return obj;
}

bool myCircularDequeIsEmpty(MyCircularDeque* obj) {
    return obj->count == 0;
}

bool myCircularDequeIsFull(MyCircularDeque* obj) {
    return obj->count == obj->capacity;
}

bool myCircularDequeInsertFront(MyCircularDeque* obj, int value) {
    if (myCircularDequeIsFull(obj)) {
        return false;
    }
    obj->front = (obj->front - 1 + obj->capacity) % obj->capacity;
    obj->arr[obj->front] = value;
    obj->count++;
    return true;
}

bool myCircularDequeInsertLast(MyCircularDeque* obj, int value) {
    if (myCircularDequeIsFull(obj)) {
        return false;
    }
    obj->arr[obj->rear] = value;
    obj->rear = (obj->rear + 1) % obj->capacity;
    obj->count++;
    return true;
}

bool myCircularDequeDeleteFront(MyCircularDeque* obj) {
    if (myCircularDequeIsEmpty(obj)) {
        return false;
    }
    obj->front = (obj->front + 1) % obj->capacity;
    obj->count--;
    return true;
}

bool myCircularDequeDeleteLast(MyCircularDeque* obj) {
    if (myCircularDequeIsEmpty(obj)) {
        return false;
    }
    obj->rear = (obj->rear - 1 + obj->capacity) % obj->capacity;
    obj->count--;
    return true;
}

int myCircularDequeGetFront(MyCircularDeque* obj) {
    if (myCircularDequeIsEmpty(obj)) {
        return -1;
    }
    return obj->arr[obj->front];
}

int myCircularDequeGetRear(MyCircularDeque* obj) {
    if (myCircularDequeIsEmpty(obj)) {
        return -1;
    }
    // rear points to the next empty slot, so the last element is at (rear - 1)
    return obj->arr[(obj->rear - 1 + obj->capacity) % obj->capacity];
}

void myCircularDequeFree(MyCircularDeque* obj) {
    free(obj->arr);
    free(obj);
}