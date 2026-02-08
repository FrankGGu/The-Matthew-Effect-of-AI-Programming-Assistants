#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* stack;
    int top;
    int capacity;
} Stack;

typedef struct {
    Stack* in_stack;
    Stack* out_stack;
} MyQueue;

Stack* stack_create(int capacity) {
    Stack* s = (Stack*)malloc(sizeof(Stack));
    s->stack = (int*)malloc(capacity * sizeof(int));
    s->top = -1;
    s->capacity = capacity;
    return s;
}

void stack_push(Stack* s, int x) {
    if (s->top >= s->capacity - 1) {
        s->stack = (int*)realloc(s->stack, (s->capacity + 1) * sizeof(int));
        s->capacity++;
    }
    s->stack[++s->top] = x;
}

int stack_pop(Stack* s) {
    if (s->top < 0) {
        return -1;
    }
    return s->stack[s->top--];
}

int stack_peek(Stack* s) {
    if (s->top < 0) {
        return -1;
    }
    return s->stack[s->top];
}

int stack_empty(Stack* s) {
    return s->top < 0;
}

MyQueue* my_queue_create() {
    MyQueue* q = (MyQueue*)malloc(sizeof(MyQueue));
    q->in_stack = stack_create(1);
    q->out_stack = stack_create(1);
    return q;
}

void my_queue_push(MyQueue* obj, int x) {
    stack_push(obj->in_stack, x);
}

int my_queue_pop(MyQueue* obj) {
    if (stack_empty(obj->out_stack)) {
        while (!stack_empty(obj->in_stack)) {
            stack_push(obj->out_stack, stack_pop(obj->in_stack));
        }
    }
    return stack_pop(obj->out_stack);
}

int my_queue_peek(MyQueue* obj) {
    if (stack_empty(obj->out_stack)) {
        while (!stack_empty(obj->in_stack)) {
            stack_push(obj->out_stack, stack_pop(obj->in_stack));
        }
    }
    return stack_peek(obj->out_stack);
}

int my_queue_empty(MyQueue* obj) {
    return stack_empty(obj->in_stack) && stack_empty(obj->out_stack);
}

void my_queue_free(MyQueue* obj) {
    free(obj->in_stack->stack);
    free(obj->in_stack);
    free(obj->out_stack->stack);
    free(obj->out_stack);
    free(obj);
}