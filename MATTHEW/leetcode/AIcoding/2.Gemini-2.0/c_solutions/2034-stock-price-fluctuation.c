#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int timestamp;
    int price;
} PriceEntry;

typedef struct {
    PriceEntry* entries;
    int capacity;
    int size;
    int latestTimestamp;
    int latestPrice;
} StockPrice;

StockPrice* stockPriceCreate() {
    StockPrice* obj = (StockPrice*)malloc(sizeof(StockPrice));
    obj->entries = (PriceEntry*)malloc(100000 * sizeof(PriceEntry));
    obj->capacity = 100000;
    obj->size = 0;
    obj->latestTimestamp = -1;
    obj->latestPrice = -1;
    return obj;
}

void stockPriceUpdate(StockPrice* obj, int timestamp, int price) {
    int found = 0;
    for (int i = 0; i < obj->size; i++) {
        if (obj->entries[i].timestamp == timestamp) {
            obj->entries[i].price = price;
            found = 1;
            break;
        }
    }
    if (!found) {
        obj->entries[obj->size].timestamp = timestamp;
        obj->entries[obj->size].price = price;
        obj->size++;
    }

    if (timestamp >= obj->latestTimestamp) {
        obj->latestTimestamp = timestamp;
        obj->latestPrice = price;
    }
    else if (timestamp == obj->latestTimestamp && price != obj->latestPrice){
         int maxTimestamp = -1;
         int maxPrice = -1;
         for(int i = 0; i < obj->size; i++){
             if(obj->entries[i].timestamp > maxTimestamp){
                 maxTimestamp = obj->entries[i].timestamp;
                 maxPrice = obj->entries[i].price;
             }
         }
         obj->latestTimestamp = maxTimestamp;
         obj->latestPrice = maxPrice;
    }
}

int stockPriceCurrent(StockPrice* obj) {
    return obj->latestPrice;
}

int stockPriceMaximum(StockPrice* obj) {
    int maxPrice = INT_MIN;
    for (int i = 0; i < obj->size; i++) {
        if (obj->entries[i].price > maxPrice) {
            maxPrice = obj->entries[i].price;
        }
    }
    return maxPrice;
}

int stockPriceMinimum(StockPrice* obj) {
    int minPrice = INT_MAX;
    for (int i = 0; i < obj->size; i++) {
        if (obj->entries[i].price < minPrice) {
            minPrice = obj->entries[i].price;
        }
    }
    return minPrice;
}

void stockPriceFree(StockPrice* obj) {
    free(obj->entries);
    free(obj);
}