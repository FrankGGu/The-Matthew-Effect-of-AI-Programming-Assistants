#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int price;
    int span;
} StockData;

typedef struct {
    StockData* data;
    int top;
    int capacity;
} StockSpanner;

StockSpanner* stockSpannerCreate() {
    StockSpanner* obj = (StockSpanner*)malloc(sizeof(StockSpanner));
    obj->capacity = 10000;
    obj->data = (StockData*)malloc(obj->capacity * sizeof(StockData));
    obj->top = -1;
    return obj;
}

int stockSpannerNext(StockSpanner* obj, int price) {
    int span = 1;
    while (obj->top >= 0 && obj->data[obj->top].price <= price) {
        span += obj->data[obj->top].span;
        obj->top--;
    }
    obj->top++;
    if (obj->top >= obj->capacity) {
        obj->capacity *= 2;
        obj->data = (StockData*)realloc(obj->data, obj->capacity * sizeof(StockData));
    }
    obj->data[obj->top].price = price;
    obj->data[obj->top].span = span;
    return span;
}

void stockSpannerFree(StockSpanner* obj) {
    free(obj->data);
    free(obj);
}