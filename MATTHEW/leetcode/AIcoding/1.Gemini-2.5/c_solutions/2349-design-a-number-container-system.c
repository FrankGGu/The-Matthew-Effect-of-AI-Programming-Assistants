#include <stdlib.h>
#include <stdbool.h>
#include <limits.h> // For INT_MAX, though not directly used for return values here.

typedef struct {
    int *data;
    int capacity;
    int size;
} MinHeap;

MinHeap* minHeapCreate(int initialCapacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (int*)malloc(sizeof(int) * initialCapacity);
    heap->capacity = initialCapacity;
    heap->size = 0;
    return heap;
}

void minHeapResize(MinHeap* heap) {
    int newCapacity = heap->capacity * 2;
    heap->data = (int*)realloc(heap->data, sizeof(int) * newCapacity);
    heap->capacity = newCapacity;
}

void minHeapSwap(MinHeap* heap, int i, int j) {
    int temp = heap->data[i];
    heap->data[i] = heap->data[j];
    heap->data[j] = temp;
}

void minHeapBubbleUp(MinHeap* heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap->data[index] < heap->data[parent]) {
        minHeapSwap(heap, index, parent);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void minHeapBubbleDown(MinHeap* heap, int index) {
    int leftChild = 2 * index + 1;
    int rightChild = 2 * index + 2;
    int smallest = index;

    if (leftChild < heap->size && heap->data[leftChild] < heap->data[smallest]) {
        smallest = leftChild;
    }
    if (rightChild < heap->size && heap->data[rightChild] < heap->data[smallest]) {
        smallest = rightChild;
    }

    if (smallest != index) {
        minHeapSwap(heap, index, smallest);
        minHeapBubbleDown(heap, smallest);
    }
}

void minHeapInsert(MinHeap* heap, int val) {
    if (heap->size == heap->capacity) {
        minHeapResize(heap);
    }
    heap->data[heap->size++] = val;
    minHeapBubbleUp(heap, heap->size - 1);
}

int minHeapExtractMin(MinHeap* heap) {
    if (heap->size == 0) {
        return -1; 
    }
    int minVal = heap->data[0];
    heap->data[0] = heap->data[--heap->size];
    minHeapBubbleDown(heap, 0);
    return minVal;
}

bool minHeapIsEmpty(MinHeap* heap) {
    return heap->size == 0;
}

void minHeapFree(MinHeap* heap) {
    if (heap) {
        free(heap->data);
        free(heap);
    }
}

typedef struct IntIntHashNode {
    int key;
    int value;
    struct IntIntHashNode *next;
} IntIntHashNode;

typedef struct IntIntHashMap {
    IntIntHashNode **buckets;
    int capacity;
    int size; 
} IntIntHashMap;

unsigned int intIntHash(int key, int capacity) {
    return (unsigned int)key % capacity;
}

IntIntHashMap* intIntHashMapCreate(int initialCapacity) {
    IntIntHashMap* map = (IntIntHashMap*)malloc(sizeof(IntIntHashMap));
    map->capacity = initialCapacity;
    map->size = 0;
    map->buckets = (IntIntHashNode**)calloc(initialCapacity, sizeof(IntIntHashNode*));
    return map;
}

void intIntHashMapPut(IntIntHashMap* map, int key, int value) {
    unsigned int hashIndex = intIntHash(key, map->capacity);
    IntIntHashNode* current = map->buckets[hashIndex];

    while (current != NULL) {
        if (current->key == key) {
            current->value = value; 
            return;
        }
        current = current->next;
    }

    IntIntHashNode* newNode = (IntIntHashNode*)malloc(sizeof(IntIntHashNode));
    newNode->key = key;
    newNode->value = value;
    newNode->next = map->buckets[hashIndex];
    map->buckets[hashIndex] = newNode;
    map->size++;
}

bool intIntHashMapGet(IntIntHashMap* map, int key, int* outValue) {
    unsigned int hashIndex = intIntHash(key, map->capacity);
    IntIntHashNode* current = map->buckets[hashIndex];

    while (current != NULL) {
        if (current->key == key) {
            *outValue = current->value;
            return true;
        }
        current = current->next;
    }
    return false;
}

void intIntHashMapFree(IntIntHashMap* map) {
    if (map) {
        for (int i = 0; i < map->capacity; i++) {
            IntIntHashNode* current = map->buckets[i];
            while (current != NULL) {
                IntIntHashNode* temp = current;
                current = current->next;
                free(temp);
            }
        }
        free(map->buckets);
        free(map);
    }
}

typedef struct IntMinHeapPtrHashNode {
    int key;
    MinHeap* value;
    struct IntMinHeapPtrHashNode *next;
} IntMinHeapPtrHashNode;

typedef struct IntMinHeapPtrHashMap {
    IntMinHeapPtrHashNode **buckets;
    int capacity;
    int size; 
} IntMinHeapPtrHashMap;

unsigned int intMinHeapPtrHash(int key, int capacity) {
    return (unsigned int)key % capacity;
}

IntMinHeapPtrHashMap* intMinHeapPtrHashMapCreate(int initialCapacity) {
    IntMinHeapPtrHashMap* map = (IntMinHeapPtrHashMap*)malloc(sizeof(IntMinHeapPtrHashMap));
    map->capacity = initialCapacity;
    map->size = 0;
    map->buckets = (IntMinHeapPtrHashNode**)calloc(initialCapacity, sizeof(IntMinHeapPtrHashNode*));
    return map;
}

void intMinHeapPtrHashMapPut(IntMinHeapPtrHashMap* map, int key, MinHeap* value) {
    unsigned int hashIndex = intMinHeapPtrHash(key, map->capacity);
    IntMinHeapPtrHashNode* current = map->buckets[hashIndex];

    while (current != NULL) {
        if (current->key == key) {
            current->value = value; 
            return;
        }
        current = current->next;
    }

    IntMinHeapPtrHashNode* newNode = (IntMinHeapPtrHashNode*)malloc(sizeof(IntMinHeapPtrHashNode));
    newNode->key = key;
    newNode->value = value;
    newNode->next = map->buckets[hashIndex];
    map->buckets[hashIndex] = newNode;
    map->size++;
}

bool intMinHeapPtrHashMapGet(IntMinHeapPtrHashMap* map, int key, MinHeap** outValue) {
    unsigned int hashIndex = intMinHeapPtrHash(key, map->capacity);
    IntMinHeapPtrHashNode* current = map->buckets[hashIndex];

    while (current != NULL) {
        if (current->key == key) {
            *outValue = current->value;
            return true;
        }
        current = current->next;
    }
    return false;
}

void intMinHeapPtrHashMapFree(IntMinHeapPtrHashMap* map) {
    if (map) {
        for (int i = 0; i < map->capacity; i++) {
            IntMinHeapPtrHashNode* current = map->buckets[i];
            while (current != NULL) {
                IntMinHeapPtrHashNode* temp = current;
                current = current->next;
                free(temp);
            }
        }
        free(map->buckets);
        free(map);
    }
}

#define INITIAL_MAP_CAPACITY 400000 
#define INITIAL_HEAP_CAPACITY 16

typedef struct {
    IntIntHashMap *index_to_number_map;      
    IntMinHeapPtrHashMap *number_to_indices_map; 
} NumberContainers;

NumberContainers* numberContainersCreate() {
    NumberContainers* obj = (NumberContainers*)malloc(sizeof(NumberContainers));
    obj->index_to_number_map = intIntHashMapCreate(INITIAL_MAP_CAPACITY);
    obj->number_to_indices_map = intMinHeapPtrHashMapCreate(INITIAL_MAP_CAPACITY);
    return obj;
}

void numberContainersChange(NumberContainers* obj, int index, int number) {
    int old_number;
    intIntHashMapGet(obj->index_to_number_map, index, &old_number); // Get old_number, if any. Not directly used for removal.

    intIntHashMapPut(obj->index_to_number_map, index, number);

    MinHeap* current_num_heap = NULL;
    if (!intMinHeapPtrHashMapGet(obj->number_to_indices_map, number, &current_num_heap)) {
        current_num_heap = minHeapCreate(INITIAL_HEAP_CAPACITY);
        intMinHeapPtrHashMapPut(obj->number_to_indices_map, number, current_num_heap);
    }
    minHeapInsert(current_num_heap, index);
}

int numberContainersFind(NumberContainers* obj, int number) {
    MinHeap* heap = NULL;
    if (!intMinHeapPtrHashMapGet(obj->number_to_indices_map, number, &heap) || minHeapIsEmpty(heap)) {
        return -1;
    }

    int current_index;
    int actual_number_at_index;

    while (!minHeapIsEmpty(heap)) {
        current_index = minHeapExtractMin(heap);

        if (intIntHashMapGet(obj->index_to_number_map, current_index, &actual_number_at_index) && 
            actual_number_at_index == number) {
            return current_index;
        }
    }
    return -1; 
}

void numberContainersFree(NumberContainers* obj) {
    if (obj) {
        for (int i = 0; i < obj->number_to_indices_map->capacity; i++) {
            IntMinHeapPtrHashNode* current = obj->number_to_indices_map->buckets[i];
            while (current != NULL) {
                minHeapFree(current->value); 
                current = current->next;
            }
        }
        intIntHashMapFree(obj->index_to_number_map);
        intMinHeapPtrHashMapFree(obj->number_to_indices_map); 
        free(obj);
    }
}