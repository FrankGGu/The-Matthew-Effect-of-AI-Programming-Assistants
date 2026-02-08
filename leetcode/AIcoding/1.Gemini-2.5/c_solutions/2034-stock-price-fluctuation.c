#include <stdlib.h>
#include <uthash.h> // Assuming uthash.h is available in the LeetCode environment

typedef struct {
    int timestamp;
    int price;
    UT_hash_handle hh;
} PriceEntry;

typedef struct {
    int price;
    int count;
    UT_hash_handle hh;
} PriceCountEntry;

int min_heap_compare(int a, int b) {
    return a < b; // Returns true if 'a' should come before 'b' in a min-heap
}

int max_heap_compare(int a, int b) {
    return a > b; // Returns true if 'a' should come before 'b' in a max-heap
}

typedef struct {
    int *data;
    int capacity;
    int size;
    int (*compare)(int, int); // Function pointer for comparison logic
} Heap;

Heap* heap_create(int capacity, int (*comp_func)(int, int)) {
    Heap* h = (Heap*)malloc(sizeof(Heap));
    h->data = (int*)malloc(sizeof(int) * capacity);
    h->capacity = capacity;
    h->size = 0;
    h->compare = comp_func;
    return h;
}

void heap_free(Heap* h) {
    if (h) {
        free(h->data);
        free(h);
    }
}

void heap_swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heap_sift_up(Heap* h, int idx) {
    int parent_idx;
    while (idx > 0) {
        parent_idx = (idx - 1) / 2;
        if (h->compare(h->data[idx], h->data[parent_idx])) {
            heap_swap(&h->data[idx], &h->data[parent_idx]);
            idx = parent_idx;
        } else {
            break;
        }
    }
}

void heap_sift_down(Heap* h, int idx) {
    int left_child_idx, right_child_idx, target_idx;
    while (1) {
        left_child_idx = 2 * idx + 1;
        right_child_idx = 2 * idx + 2;
        target_idx = idx;

        if (left_child_idx < h->size && h->compare(h->data[left_child_idx], h->data[target_idx])) {
            target_idx = left_child_idx;
        }
        if (right_child_idx < h->size && h->compare(h->data[right_child_idx], h->data[target_idx])) {
            target_idx = right_child_idx;
        }

        if (target_idx != idx) {
            heap_swap(&h->data[idx], &h->data[target_idx]);
            idx = target_idx;
        } else {
            break;
        }
    }
}

void heap_push(Heap* h, int val) {
    if (h->size == h->capacity) {
        h->capacity *= 2;
        h->data = (int*)realloc(h->data, sizeof(int) * h->capacity);
    }
    h->data[h->size++] = val;
    heap_sift_up(h, h->size - 1);
}

int heap_pop(Heap* h) {
    if (h->size == 0) return -1;
    int root = h->data[0];
    h->data[0] = h->data[--h->size];
    heap_sift_down(h, 0);
    return root;
}

int heap_peek(Heap* h) {
    if (h->size == 0) return -1;
    return h->data[0];
}

int heap_is_empty(Heap* h) {
    return h->size == 0;
}

typedef struct {
    PriceEntry *timestampToPriceMap; // Maps timestamp to its current price
    PriceCountEntry *priceCountsMap; // Maps price to its count in timestampToPriceMap (for lazy deletion)
    Heap *maxHeap;
    Heap *minHeap;
    int latestTimestamp;
    int latestPrice;
} StockPrice;

StockPrice* stockPriceCreate() {
    StockPrice* obj = (StockPrice*)malloc(sizeof(StockPrice));
    obj->timestampToPriceMap = NULL;
    obj->priceCountsMap = NULL;

    int heap_initial_capacity = 200005; // Max updates is 2 * 10^5
    obj->maxHeap = heap_create(heap_initial_capacity, max_heap_compare);
    obj->minHeap = heap_create(heap_initial_capacity, min_heap_compare);

    obj->latestTimestamp = 0;
    obj->latestPrice = 0;
    return obj;
}

void stockPriceUpdate(StockPrice* obj, int timestamp, int price) {
    PriceEntry *pEntry;
    PriceCountEntry *pcEntry;
    int oldPrice = -1;

    HASH_FIND_INT(obj->timestampToPriceMap, &timestamp, pEntry);
    if (pEntry) {
        oldPrice = pEntry->price;
        pEntry->price = price;
    } else {
        pEntry = (PriceEntry*)malloc(sizeof(PriceEntry));
        pEntry->timestamp = timestamp;
        pEntry->price = price;
        HASH_ADD_INT(obj->timestampToPriceMap, timestamp, pEntry);
    }

    if (oldPrice != -1) {
        HASH_FIND_INT(obj->priceCountsMap, &oldPrice, pcEntry);
        if (pcEntry) {
            pcEntry->count--;
            if (pcEntry->count == 0) {
                HASH_DEL(obj->priceCountsMap, pcEntry);
                free(pcEntry);
            }
        }
    }

    HASH_FIND_INT(obj->priceCountsMap, &price, pcEntry);
    if (pcEntry) {
        pcEntry->count++;
    } else {
        pcEntry = (PriceCountEntry*)malloc(sizeof(PriceCountEntry));
        pcEntry->price = price;
        pcEntry->count = 1;
        HASH_ADD_INT(obj->priceCountsMap, price, pcEntry);
    }

    heap_push(obj->maxHeap, price);
    heap_push(obj->minHeap, price);

    if (timestamp >= obj->latestTimestamp) {
        obj->latestTimestamp = timestamp;
        obj->latestPrice = price;
    }
}

int stockPriceCurrent(StockPrice* obj) {
    return obj->latestPrice;
}

int stockPriceMaximum(StockPrice* obj) {
    PriceCountEntry *pcEntry;
    int maxPrice;
    while (1) {
        maxPrice = heap_peek(obj->maxHeap);
        HASH_FIND_INT(obj->priceCountsMap, &maxPrice, pcEntry);
        if (pcEntry && pcEntry->count > 0) {
            return maxPrice;
        }
        heap_pop(obj->maxHeap);
    }
}

int stockPriceMinimum(StockPrice* obj) {
    PriceCountEntry *pcEntry;
    int minPrice;
    while (1) {
        minPrice = heap_peek(obj->minHeap);
        HASH_FIND_INT(obj->priceCountsMap, &minPrice, pcEntry);
        if (pcEntry && pcEntry->count > 0) {
            return minPrice;
        }
        heap_pop(obj->minHeap);
    }
}

void stockPriceFree(StockPrice* obj) {
    PriceEntry *current_p, *tmp_p;
    HASH_ITER(hh, obj->timestampToPriceMap, current_p, tmp_p) {
        HASH_DEL(obj->timestampToPriceMap, current_p);
        free(current_p);
    }

    PriceCountEntry *current_pc, *tmp_pc;
    HASH_ITER(hh, obj->priceCountsMap, current_pc, tmp_pc) {
        HASH_DEL(obj->priceCountsMap, current_pc);
        free(current_pc);
    }

    heap_free(obj->maxHeap);
    heap_free(obj->minHeap);
    free(obj);
}