typedef struct {
    int timestamp;
    int price;
} StockPrice;

typedef struct {
    StockPrice *prices;
    int size;
    int capacity;
} StockPriceTracker;

StockPriceTracker* stockPriceTrackerCreate() {
    StockPriceTracker *tracker = malloc(sizeof(StockPriceTracker));
    tracker->size = 0;
    tracker->capacity = 10;
    tracker->prices = malloc(sizeof(StockPrice) * tracker->capacity);
    return tracker;
}

void stockPriceTrackerUpdate(StockPriceTracker* obj, int timestamp, int price) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->prices = realloc(obj->prices, sizeof(StockPrice) * obj->capacity);
    }
    obj->prices[obj->size++] = (StockPrice){timestamp, price};
}

int stockPriceTrackerCurrent(StockPriceTracker* obj) {
    int maxPrice = 0;
    for (int i = 0; i < obj->size; i++) {
        if (obj->prices[i].price > maxPrice) {
            maxPrice = obj->prices[i].price;
        }
    }
    return maxPrice;
}

int stockPriceTrackerMaximum(StockPriceTracker* obj) {
    int maxPrice = 0;
    for (int i = 0; i < obj->size; i++) {
        if (obj->prices[i].price > maxPrice) {
            maxPrice = obj->prices[i].price;
        }
    }
    return maxPrice;
}

int stockPriceTrackerMinimum(StockPriceTracker* obj) {
    int minPrice = INT_MAX;
    for (int i = 0; i < obj->size; i++) {
        if (obj->prices[i].price < minPrice) {
            minPrice = obj->prices[i].price;
        }
    }
    return minPrice;
}

void stockPriceTrackerFree(StockPriceTracker* obj) {
    free(obj->prices);
    free(obj);
}