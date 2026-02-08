#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int timestamp;
    int price;
} StockPrice;

typedef struct {
    int* timestamps;
    int* prices;
    int size;
    int capacity;
} StockPriceManager;

StockPriceManager* stockPriceManagerCreate() {
    StockPriceManager* manager = (StockPriceManager*)malloc(sizeof(StockPriceManager));
    manager->timestamps = (int*)malloc(sizeof(int) * 1000);
    manager->prices = (int*)malloc(sizeof(int) * 1000);
    manager->size = 0;
    manager->capacity = 1000;
    return manager;
}

void stockPriceManagerUpdate(StockPriceManager* obj, int timestamp, int price) {
    if (obj->size >= obj->capacity) {
        obj->capacity *= 2;
        obj->timestamps = (int*)realloc(obj->timestamps, sizeof(int) * obj->capacity);
        obj->prices = (int*)realloc(obj->prices, sizeof(int) * obj->capacity);
    }
    obj->timestamps[obj->size] = timestamp;
    obj->prices[obj->size] = price;
    obj->size++;
}

int stockPriceManagerCurrent(StockPriceManager* obj) {
    int maxTimestamp = -1;
    int currentPrice = -1;
    for (int i = 0; i < obj->size; i++) {
        if (obj->timestamps[i] > maxTimestamp) {
            maxTimestamp = obj->timestamps[i];
            currentPrice = obj->prices[i];
        }
    }
    return currentPrice;
}

int stockPriceManagerMaximum(StockPriceManager* obj) {
    int maxPrice = INT_MIN;
    for (int i = 0; i < obj->size; i++) {
        if (obj->prices[i] > maxPrice) {
            maxPrice = obj->prices[i];
        }
    }
    return maxPrice;
}

int stockPriceManagerMinimum(StockPriceManager* obj) {
    int minPrice = INT_MAX;
    for (int i = 0; i < obj->size; i++) {
        if (obj->prices[i] < minPrice) {
            minPrice = obj->prices[i];
        }
    }
    return minPrice;
}

void stockPriceManagerFree(StockPriceManager* obj) {
    free(obj->timestamps);
    free(obj->prices);
    free(obj);
}