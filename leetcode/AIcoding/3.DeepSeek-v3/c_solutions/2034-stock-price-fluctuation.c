typedef struct {
    int* prices;
    int* timestamps;
    int capacity;
    int size;
    int latestTime;
    int maxPrice;
    int minPrice;
    int maxValid;
    int minValid;
} StockPrice;

StockPrice* stockPriceCreate() {
    StockPrice* obj = (StockPrice*)malloc(sizeof(StockPrice));
    obj->capacity = 10000;
    obj->prices = (int*)malloc(sizeof(int) * obj->capacity);
    obj->timestamps = (int*)malloc(sizeof(int) * obj->capacity);
    obj->size = 0;
    obj->latestTime = 0;
    obj->maxPrice = 0;
    obj->minPrice = 0;
    obj->maxValid = 0;
    obj->minValid = 0;
    return obj;
}

void stockPriceUpdate(StockPrice* obj, int timestamp, int price) {
    int found = 0;
    for (int i = 0; i < obj->size; i++) {
        if (obj->timestamps[i] == timestamp) {
            obj->prices[i] = price;
            found = 1;
            break;
        }
    }

    if (!found) {
        if (obj->size >= obj->capacity) {
            obj->capacity *= 2;
            obj->prices = (int*)realloc(obj->prices, sizeof(int) * obj->capacity);
            obj->timestamps = (int*)realloc(obj->timestamps, sizeof(int) * obj->capacity);
        }
        obj->timestamps[obj->size] = timestamp;
        obj->prices[obj->size] = price;
        obj->size++;
    }

    if (timestamp >= obj->latestTime) {
        obj->latestTime = timestamp;
    }

    obj->maxValid = 0;
    obj->minValid = 0;
}

int stockPriceCurrent(StockPrice* obj) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->timestamps[i] == obj->latestTime) {
            return obj->prices[i];
        }
    }
    return -1;
}

int stockPriceMaximum(StockPrice* obj) {
    if (!obj->maxValid) {
        obj->maxPrice = 0;
        for (int i = 0; i < obj->size; i++) {
            if (obj->prices[i] > obj->maxPrice) {
                obj->maxPrice = obj->prices[i];
            }
        }
        obj->maxValid = 1;
    }
    return obj->maxPrice;
}

int stockPriceMinimum(StockPrice* obj) {
    if (!obj->minValid) {
        obj->minPrice = INT_MAX;
        for (int i = 0; i < obj->size; i++) {
            if (obj->prices[i] < obj->minPrice) {
                obj->minPrice = obj->prices[i];
            }
        }
        obj->minValid = 1;
    }
    return obj->minPrice;
}

void stockPriceFree(StockPrice* obj) {
    free(obj->prices);
    free(obj->timestamps);
    free(obj);
}