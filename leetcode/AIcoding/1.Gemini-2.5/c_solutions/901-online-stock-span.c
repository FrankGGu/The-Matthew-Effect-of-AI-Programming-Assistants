#include <stdlib.h>

typedef struct {
    int price;
    int span;
} StackElement;

typedef struct {
    StackElement *stack;
    int top;
    int capacity;
} StockSpanner;

StockSpanner* stockSpannerCreate() {
    StockSpanner *obj = (StockSpanner*) malloc(sizeof(StockSpanner));
    if (obj == NULL) {
        return NULL;
    }
    obj->capacity = 16;
    obj->stack = (StackElement*) malloc(sizeof(StackElement) * obj->capacity);
    if (obj->stack == NULL) {
        free(obj);
        return NULL;
    }
    obj->top = -1;
    return obj;
}

int stockSpannerNext(StockSpanner* obj, int price) {
    int current_span = 1;

    while (obj->top >= 0 && obj->stack[obj->top].price <= price) {
        current_span += obj->stack[obj->top].span;
        obj->top--;
    }

    if (obj->top + 1 == obj->capacity) {
        obj->capacity *= 2;
        StackElement *new_stack = (StackElement*) realloc(obj->stack, sizeof(StackElement) * obj->capacity);
        if (new_stack == NULL) {
            return -1; 
        }
        obj->stack = new_stack;
    }

    obj->top++;
    obj->stack[obj->top].price = price;
    obj->stack[obj->top].span = current_span;

    return current_span;
}

void stockSpannerFree(StockSpanner* obj) {
    if (obj == NULL) {
        return;
    }
    free(obj->stack);
    free(obj);
}