#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int profit;
    int category;
} Item;

int compareItems(const void *a, const void *b) {
    Item *itemA = (Item *)a;
    Item *itemB = (Item *)b;
    // Sort in descending order of profit
    return itemB->profit - itemA->profit;
}

typedef struct {
    Item *data;
    int size;
    int capacity;
} MinHeapItems;

void initHeapItems(MinHeapItems *heap, int capacity) {
    heap->data = (Item *)malloc(sizeof(Item) * capacity);
    heap->size = 0;
    heap->capacity = capacity;
}

void freeHeapItems(MinHeapItems *heap) {
    free(heap->data);
    heap->data = NULL;
    heap->size = 0;
    heap->capacity = 0;
}

void swapItems(Item *a, Item *b) {
    Item temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUpItems(MinHeapItems *heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap->data[index].profit < heap->data[parent].profit) {
        swapItems(&heap->data[index], &heap->data[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapifyDownItems(MinHeapItems *heap, int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heap->size && heap->data[left].profit < heap->data[smallest].profit) {
        smallest = left;
    }
    if (right < heap->size && heap->data[right].profit < heap->data[smallest].profit) {
        smallest = right;
    }

    if (smallest != index) {
        swapItems(&heap->data[index], &heap->data[smallest]);
        heapifyDownItems(heap, smallest);
    }
}

void pushHeapItems(MinHeapItems *heap, Item value) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2; // Double capacity
        heap->data = (Item *)realloc(heap->data, sizeof(Item) * heap->capacity);
    }
    heap->data[heap->size] = value;
    heap->size++;
    heapifyUpItems(heap, heap->size - 1);
}

Item popHeapItems(MinHeapItems *heap) {
    // Return a sentinel value if heap is empty
    Item root_sentinel = {-1, -1}; 
    if (heap->size == 0) {
        return root_sentinel;
    }
    Item root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDownItems(heap, 0);
    return root;
}

Item topHeapItems(MinHeapItems *heap) {
    // Return a sentinel value if heap is empty
    Item root_sentinel = {-1, -1};
    if (heap->size == 0) {
        return root_sentinel;
    }
    return heap->data[0];
}

bool isHeapItemsEmpty(MinHeapItems *heap) {
    return heap->size == 0;
}

#define MAX_CATEGORY_VALUE 100001 
int category_counts[MAX_CATEGORY_VALUE];

long long maxElegance(int** items_raw, int itemsSize, int* itemsColSize, int k) {
    // Convert raw 2D array to Item struct array
    Item *items = (Item *)malloc(sizeof(Item) * itemsSize);
    for (int i = 0; i < itemsSize; ++i) {
        items[i].profit = items_raw[i][0];
        items[i].category = items_raw[i][1];
    }

    // Sort items by profit in descending order
    qsort(items, itemsSize, sizeof(Item), compareItems);

    long long current_profit = 0;
    int distinct_categories = 0;

    // Initialize category_counts to all zeros for each test case
    for (int i = 0; i < MAX_CATEGORY_VALUE; ++i) {
        category_counts[i] = 0;
    }

    MinHeapItems duplicates_pq;
    // Initial capacity for duplicates_pq is k. In worst case, all k initial items could be duplicates.
    initHeapItems(&duplicates_pq, k); 

    // 1. Process the initial k most profitable items
    for (int i = 0; i < k; ++i) {
        current_profit += items[i].profit;
        if (category_counts[items[i].category] == 0) {
            distinct_categories++;
        } else {
            // This item's category is already present among the initial k items.
            // Add it to the min-priority queue of duplicates.
            pushHeapItems(&duplicates_pq, items[i]);
        }
        category_counts[items[i].category]++;
    }

    long long max_elegance = current_profit + (long long)distinct_categories * distinct_categories;

    // 2. Iterate through remaining items (from k to itemsSize-1)
    //    These are items with lower profit than the initial k.
    //    We try to swap an item from our current k-set with a new item if it introduces a new category
    //    and we can remove a duplicate item from our current set to minimize profit loss.
    for (int i = k; i < itemsSize; ++i) {
        // Condition to consider a swap:
        // a) The current item's category is new (not present in our current k selected items).
        // b) We have at least one item in our current k-set that belongs to a duplicate category
        //    (i.e., category_counts[some_category] > 1), which we can remove without reducing distinct_categories.
        if (category_counts[items[i].category] == 0 && !isHeapItemsEmpty(&duplicates_pq)) {
            Item item_to_remove = {-1, -1}; // Sentinel

            // Find the smallest profit item from duplicates_pq that is actually a duplicate (count > 1)
            while (!isHeapItemsEmpty(&duplicates_pq)) {
                Item potential_remove = topHeapItems(&duplicates_pq);
                if (category_counts[potential_remove.category] > 1) {
                    // This item is a valid duplicate to remove.
                    item_to_remove = popHeapItems(&duplicates_pq);
                    break;
                } else {
                    // This item is no longer a duplicate (its category count is 1).
                    // Removing it would decrease distinct_categories, which we don't want.
                    // Discard it from the PQ and look for the next smallest.
                    popHeapItems(&duplicates_pq);
                }
            }

            // If item_to_remove is still sentinel, it means duplicates_pq became empty
            // or all remaining items in PQ were no longer true duplicates.
            if (item_to_remove.profit == -1) {
                continue; // Cannot find a suitable item to swap out, move to next item
            }

            // Perform the swap
            current_profit = current_profit - item_to_remove.profit + items[i].profit;
            distinct_categories++; // New category introduced

            // Update category counts for the swapped items
            category_counts[item_to_remove.category]--; 
            category_counts[items[i].category]++;       

            long long current_elegance = current_profit + (long long)distinct_categories * distinct_categories;
            if (current_elegance > max_elegance) {
                max_elegance = current_elegance;
            }
        }
    }

    free(items);
    freeHeapItems(&duplicates_pq);

    return max_elegance;
}