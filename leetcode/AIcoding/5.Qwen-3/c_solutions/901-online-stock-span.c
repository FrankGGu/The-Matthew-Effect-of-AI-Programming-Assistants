#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* prices;
    int* spans;
    int index;
} StockSpanner;

StockSpanner* stockSpannerCreate() {
    StockSpanner* obj = (StockSpanner*)malloc(sizeof(StockSpanner));
    obj->prices = (int*)malloc(1000 * sizeof(int));
    obj->spans = (int*)malloc(1000 * sizeof(int));
    obj->index = -1;
    return obj;
}

int stockSpannerNext(StockSpanner* obj, int price) {
    obj->index++;
    obj->prices[obj->index] = price;
    int span = 1;
    int i = obj->index - 1;
    while (i >= 0 && obj->prices[i] <= price) {
        span += obj->spans[i];
        i -= obj->spans[i];
    }
    obj->spans[obj->index] = span;
    return span;
}

void stockSpannerFree(StockSpanner* obj) {
    free(obj->prices);
    free(obj->spans);
    free(obj);
}