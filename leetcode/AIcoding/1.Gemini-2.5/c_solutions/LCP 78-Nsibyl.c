#include <stdlib.h> // For malloc, free, qsort

typedef struct {
    int x;
    int h; // Negative for start height, positive for end height
} Event;

int compareEvents(const void* a, const void* b) {
    Event* eventA = (Event*)a;
    Event* eventB = (Event*)b;

    if (eventA->x != eventB->x) {
        return eventA->x - eventB->x;
    }
    // If x coordinates are the same:
    // 1. Start points (negative h) come before end points (positive h).
    // 2. Among start points, taller buildings come first (smaller negative h).
    // 3. Among end points, shorter buildings come first (smaller positive h).
    // This combined rule `eventA->h - eventB->h` handles all cases.
    return eventA->h - eventB->h;
}

typedef struct {
    int* data;
    int size;
    int capacity;
} MaxHeap;

void init_heap(MaxHeap* heap, int initial_capacity) {
    heap->data = (int*)malloc(sizeof(int) * initial_capacity);
    heap->size = 0;
    heap->capacity = initial_capacity;
}

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heapify_up(MaxHeap* heap, int idx) {
    int parent = (idx - 1) / 2;
    while (idx > 0 && heap->data[idx] > heap->data[parent]) {
        swap(&heap->data[idx], &heap->data[parent]);
        idx = parent;
        parent = (idx - 1) / 2;
    }
}

void heapify_down(MaxHeap* heap, int idx) {
    int largest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < heap->size && heap->data[left] > heap->data[largest]) {
        largest = left;
    }
    if (right < heap->size && heap->data[right] > heap->data[largest]) {
        largest = right;
    }

    if (largest != idx) {
        swap(&heap->data[idx], &heap->data[largest]);
        heapify_down(heap, largest);
    }
}

void heap_insert(MaxHeap* heap, int val) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = (int*)realloc(heap->data, sizeof(int) * heap->capacity);
    }
    heap->data[heap->size] = val;
    heap->size++;
    heapify_up(heap, heap->size - 1);
}

int heap_peek(MaxHeap* heap) {
    if (heap->size == 0) return 0;
    return heap->data[0];
}

int heap_extract_max(MaxHeap* heap) {
    if (heap->size == 0) return 0;
    int max_val = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    if (heap->size > 0) { // Only heapify down if there are elements left
        heapify_down(heap, 0);
    }
    return max_val;
}

#define HASH_MAP_INITIAL_CAPACITY 1021 // A prime number

typedef struct HashMapNode {
    int key;
    int value; // Count of the height
    struct HashMapNode* next;
} HashMapNode;

typedef struct {
    HashMapNode** buckets;
    int capacity;
    int size; // Number of unique keys
} HashMap;

unsigned int hash_func(int key, int capacity) {
    return (unsigned int)(key * 2654435761U) % capacity;
}

void init_hash_map(HashMap* map, int initial_capacity) {
    map->capacity = initial_capacity;
    map->size = 0;
    map->buckets = (HashMapNode**)calloc(map->capacity, sizeof(HashMapNode*));
}

void resize_hash_map(HashMap* map, int new_capacity) {
    HashMapNode** old_buckets = map->buckets;
    int old_capacity = map->capacity;

    map->capacity = new_capacity;
    map->buckets = (HashMapNode**)calloc(new_capacity, sizeof(HashMapNode*));
    map->size = 0; // Will be re-counted during re-insertion

    for (int i = 0; i < old_capacity; ++i) {
        HashMapNode* current = old_buckets[i];
        while (current) {
            HashMapNode* next_node = current->next;

            // Re-insert into new map
            unsigned int idx = hash_func(current->key, map->capacity);
            current->next = map->buckets[idx];
            map->buckets[idx] = current;
            map->size++;

            current = next_node;
        }
    }
    free(old_buckets);
}

void hash_map_put(HashMap* map, int key, int value) {
    // Check load factor and resize if necessary
    // A load factor of 0.75 is common for chained hash maps
    if ((float)map->size / map->capacity > 0.75) {
        resize_hash_map(map, map->capacity * 2 + 1); // Double capacity and keep it odd/prime-ish
    }

    unsigned int idx = hash_func(key, map->capacity);
    HashMapNode* current = map->buckets[idx];
    while (current) {
        if (current->key == key) {
            current->value = value;
            return;
        }
        current = current->next;
    }
    // Key not found, add new node
    HashMapNode* newNode = (HashMapNode*)malloc(sizeof(HashMapNode));
    newNode->key = key;
    newNode->value = value;
    newNode->next = map->buckets[idx];
    map->buckets[idx] = newNode;
    map->size++;
}

int hash_map_get(HashMap* map, int key) {
    unsigned int idx = hash_func(key, map->capacity);
    HashMapNode* current = map->buckets[idx];
    while (current) {
        if (current->key == key) {
            return current->value;
        }
        current = current->next;
    }
    return 0; // Key not found, return 0 (assuming counts start at 0)
}

void hash_map_increment(HashMap* map, int key) {
    hash_map_put(map, key, hash_map_get(map, key) + 1);
}

void hash_map_decrement(HashMap* map, int key) {
    hash_map_put(map, key, hash_map_get(map, key) - 1);
}

void free_hash_map(HashMap* map) {
    for (int i = 0; i < map->capacity; ++i) {
        HashMapNode* current = map->buckets[i];
        while (current) {
            HashMapNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(map->buckets);
}

int** getSkyline(int** buildings, int buildingsSize, int* buildingsColSize, int* returnSize, int** returnColumnSizes) {
    if (buildingsSize == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int num_events = 2 * buildingsSize;
    Event* events = (Event*)malloc(sizeof(Event) * num_events);
    if (!events) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    for (int i = 0; i < buildingsSize; ++i) {
        int left = buildings[i][0];
        int right = buildings[i][1];
        int height = buildings[i][2];

        events[2 * i].x = left;
        events[2 * i].h = -height; // Start event, negative height
        events[2 * i + 1].x = right;
        events[2 * i + 1].h = height; // End event, positive height
    }

    qsort(events, num_events, sizeof(Event), compareEvents);

    MaxHeap heap;
    init_heap(&heap, buildingsSize + 1); 

    HashMap counts;
    init_hash_map(&counts, HASH_MAP_INITIAL_CAPACITY); 

    int** result = (int**)malloc(sizeof(int*) * num_events); 
    *returnColumnSizes = (int*)malloc(sizeof(int) * num_events);
    if (!result || !(*returnColumnSizes)) {
        free(events);
        free(heap.data);
        free_hash_map(&counts);
        if (result) free(result);
        if (*returnColumnSizes) free(*returnColumnSizes);
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int result_idx = 0;
    int prev_max_height = 0;

    for (int i = 0; i < num_events; ++i) {
        int x = events[i].x;
        int h_val = events[i].h;

        if (h_val < 0) { // Start event
            int height = -h_val;
            heap_insert(&heap, height);
            hash_map_increment(&counts, height);
        } else { // End event
            int height = h_val;
            hash_map_decrement(&counts, height);
        }

        while (heap.size > 0 && hash_map_get(&counts, heap_peek(&heap)) == 0) {
            heap_extract_max(&heap);
        }

        int current_max_height = heap_peek(&heap);

        if (current_max_height != prev_max_height) {
            result[result_idx] = (int*)malloc(sizeof(int) * 2);
            if (!result[result_idx]) {
                for (int j = 0; j < result_idx; ++j) {
                    free(result[j]);
                }
                free(result);
                free(*returnColumnSizes);
                free(events);
                free(heap.data);
                free_hash_map(&counts);
                *returnSize = 0;
                *returnColumnSizes = NULL;
                return NULL;
            }
            result[result_idx][0] = x;
            result[result_idx][1] = current_max_height;
            (*returnColumnSizes)[result_idx] = 2;
            result_idx++;
            prev_max_height = current_max_height;
        }
    }

    *returnSize = result_idx;

    free(events);
    free(heap.data);
    free_hash_map(&counts);

    return result;
}