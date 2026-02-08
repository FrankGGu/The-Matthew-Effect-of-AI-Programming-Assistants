#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* queue1;
    int* queue2;
    int size;
    int head1;
    int tail1;
    int head2;
    int tail2;
    int count;
} MyStack;

MyStack* myStackCreate() {
    MyStack* stack = (MyStack*)malloc(sizeof(MyStack));
    stack->size = 100;
    stack->queue1 = (int*)malloc(stack->size * sizeof(int));
    stack->queue2 = (int*)malloc(stack->size * sizeof(int));
    stack->head1 = 0;
    stack->tail1 = 0;
    stack->head2 = 0;
    stack->tail2 = 0;
    stack->count = 0;
    return stack;
}

void myStackPush(MyStack* obj, int x) {
    if (obj->count == obj->size) {
        obj->size *= 2;
        obj->queue1 = (int*)realloc(obj->queue1, obj->size * sizeof(int));
        obj->queue2 = (int*)realloc(obj->queue2, obj->size * sizeof(int));
    }
    obj->queue1[obj->tail1] = x;
    obj->tail1 = (obj->tail1 + 1) % obj->size;
    obj->count++;
}

int myStackPop(MyStack* obj) {
    int i;
    if (obj->count == 0) return -1;

    while (obj->count > 1) {
        obj->queue2[obj->tail2] = obj->queue1[obj->head1];
        obj->tail2 = (obj->tail2 + 1) % obj->size;
        obj->head1 = (obj->head1 + 1) % obj->size;
        obj->count--;
    }

    int val = obj->queue1[obj->head1];
    obj->head1 = (obj->head1 + 1) % obj->size;
    obj->count--;

    int* temp = obj->queue1;
    obj->queue1 = obj->queue2;
    obj->queue2 = temp;

    int temp_head = obj->head1;
    obj->head1 = obj->head2;
    obj->head2 = temp_head;

    int temp_tail = obj->tail1;
    obj->tail1 = obj->tail2;
    obj->tail2 = temp_tail;

    return val;
}

int myStackTop(MyStack* obj) {
    int i;
    if (obj->count == 0) return -1;

    while (obj->count > 1) {
        obj->queue2[obj->tail2] = obj->queue1[obj->head1];
        obj->tail2 = (obj->tail2 + 1) % obj->size;
        obj->head1 = (obj->head1 + 1) % obj->size;
        obj->count--;
    }

    int val = obj->queue1[obj->head1];

    obj->queue2[obj->tail2] = obj->queue1[obj->head1];
    obj->tail2 = (obj->tail2 + 1) % obj->size;
    obj->head1 = (obj->head1 + 1) % obj->size;
    obj->count--;
    obj->count++;

    int* temp = obj->queue1;
    obj->queue1 = obj->queue2;
    obj->queue2 = temp;

    int temp_head = obj->head1;
    obj->head1 = obj->head2;
    obj->head2 = temp_head;

    int temp_tail = obj->tail1;
    obj->tail1 = obj->tail2;
    obj->tail2 = temp_tail;

    return val;
}

bool myStackEmpty(MyStack* obj) {
    return obj->count == 0;
}

void myStackFree(MyStack* obj) {
    free(obj->queue1);
    free(obj->queue2);
    free(obj);
}