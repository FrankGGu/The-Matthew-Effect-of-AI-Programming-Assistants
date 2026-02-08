#include <stdlib.h>
#include <string.h> // For memset

#define HASH_TABLE_SIZE 200003 // A larger prime number

typedef struct HashMapNode {
    int key;
    int val; // Count
    struct HashMapNode *next;
} HashMapNode;

HashMapNode *hashTable[HASH_TABLE_SIZE];

unsigned int hash(int key) {
    // Use a larger type for intermediate calculation to prevent overflow
    return (unsigned int)(((long long)key * 31 + 17) % HASH_TABLE_SIZE + HASH_TABLE_SIZE) % HASH_TABLE_SIZE;
}

void hashMapInit() {
    memset(hashTable, 0, sizeof(hashTable));
}

void hashMapFree() {
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        HashMapNode *node = hashTable[i];
        while (node) {
            HashMapNode *temp = node;
            node = node->next;
            free(temp);
        }
        hashTable[i] = NULL;
    }
}

int hashMapGet(int key) {
    unsigned int idx = hash(key);
    HashMapNode *node = hashTable[idx];
    while (node) {
        if (node->key == key) {
            return node->val;
        }
        node = node->next;
    }
    return 0; // Key not found, count is 0
}

void hashMapPut(int key, int val) {
    unsigned int idx = hash(key);
    HashMapNode *node = hashTable[idx];
    while (node) {
        if (node->key == key) {
            node->val = val;
            return;
        }
        node = node->next;
    }
    // Key not found, create new node
    HashMapNode *newNode = (HashMapNode *)malloc(sizeof(HashMapNode));
    if (!newNode) {
        exit(EXIT_FAILURE); // Handle allocation failure
    }
    newNode->key = key;
    newNode->val = val;
    newNode->next = hashTable[idx];
    hashTable[idx] = newNode;
}

void hashMapIncrement(int key) {
    hashMapPut(key, hashMapGet(key) + 1);
}

void hashMapDecrement(int key) {
    hashMapPut(key, hashMapGet(key) - 1);
}

typedef struct {
    long long *arr;
    int capacity;
    int size;
    int is_max_heap; // 1 for max-heap, 0 for min-heap
} Heap;

void swap(long long *a, long long *b) {
    long long temp = *a;
    *a = *b;
    *b = temp;
}

Heap* createHeap(int capacity, int is_max_heap) {
    Heap *heap = (Heap *)malloc(sizeof(Heap));
    if (!heap) {
        exit(EXIT_FAILURE);
    }
    heap->arr = (long long *)malloc(sizeof(long long) * capacity);
    if (!heap->arr) {
        free(heap);
        exit(EXIT_FAILURE);
    }
    heap->capacity = capacity;
    heap->size = 0;
    heap->is_max_heap = is_max_heap;
    return heap;
}

void freeHeap(Heap *heap) {
    free(heap->arr);
    free(heap);
}

int compare(Heap *heap, int idx1, int idx2) {
    if (heap->is_max_heap) {
        return heap->arr[idx1] > heap->arr[idx2];
    } else {
        return heap->arr[idx1] < heap->arr[idx2];
    }
}

void heapifyUp(Heap *heap, int idx) {
    int parent = (idx - 1) / 2;
    while (idx > 0 && compare(heap, idx, parent)) {
        swap(&heap->arr[idx], &heap->arr[parent]);
        idx = parent;
        parent = (idx - 1) / 2;
    }
}

void heapifyDown(Heap *heap, int idx) {
    int largestOrSmallest = idx;
    int leftChild = 2 * idx + 1;
    int rightChild = 2 * idx + 2;

    if (leftChild < heap->size && compare(heap, leftChild, largestOrSmallest)) {
        largestOrSmallest = leftChild;
    }
    if (rightChild < heap->size && compare(heap, rightChild, largestOrSmallest)) {
        largestOrSmallest = rightChild;
    }

    if (largestOrSmallest != idx) {
        swap(&heap->arr[idx], &heap->arr[largestOrSmallest]);
        heapifyDown(heap, largestOrSmallest);
    }
}

void heapPush(Heap *heap, long long val) {
    if (heap->size == heap->capacity) {
        // This case indicates an issue with capacity management, but for this problem,
        // the capacity 'k' should be sufficient for each heap.
        return; 
    }
    heap->arr[heap->size++] = val;
    heapifyUp(heap, heap->size - 1);
}

long long heapPop(Heap *heap) {
    long long val = heap->arr[0];
    heap->arr[0] = heap->arr[--heap->size];
    heapifyDown(heap, 0);
    return val;
}

long long heapPeek(Heap *heap) {
    return heap->arr[0];
}

void balanceHeaps(Heap *max_heap, Heap *min_heap) {
    // Ensure max_heap size is either equal to min_heap size or one greater
    while (max_heap->size < min_heap->size) {
        long long val = heapPop(min_heap);
        heapPush(max_heap, val);
    }
    while (max_heap->size > min_heap->size + 1) {
        long long val = heapPop(max_heap);
        heapPush(min_heap, val);
    }
}

void cleanHeaps(Heap *max_heap, Heap *min_heap) {
    while (max_heap->size > 0 && hashMapGet(heapPeek(max_heap)) == 0) {
        heapPop(max_heap);
    }
    while (min_heap->size > 0 && hashMapGet(heapPeek(min_heap)) == 0) {
        heapPop(min_heap);
    }
}

double* medianSlidingWindow(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = numsSize - k + 1;
    if (*returnSize <= 0) {
        *returnSize = 0; // Ensure returnSize is 0 for invalid k
        return NULL;
    }

    double *result = (double *)malloc(sizeof(double) * (*returnSize));
    if (!result) {
        *returnSize = 0;
        return NULL;
    }

    hashMapInit();
    // Each heap can temporarily hold up to k elements before balancing,
    // so capacity should be k.
    Heap *max_heap = createHeap(k, 1); // Stores smaller half
    Heap *min_heap = createHeap(k, 0); // Stores larger half

    // Initialize first window
    for (int i = 0; i < k; ++i) {
        // Add all elements to max_heap first, then balance.
        // This simplifies initial placement logic.
        heapPush(max_heap, nums[i]);
        hashMapIncrement(nums[i]);
        balanceHeaps(max_heap, min_heap);
    }

    // Calculate median for first window
    if (k % 2 == 1) {
        result[0] = (double)heapPeek(max_heap);
    } else {
        result[0] = ((double)heapPeek(max_heap) + (double)heapPeek(min_heap)) / 2.0;
    }

    // Slide the window
    for (int i = k; i < numsSize; ++i) {
        // Add new element
        int new_val = nums[i];
        // Compare with current max of smaller half to decide which heap to push to
        if (new_val <= heapPeek(max_heap)) { 
            heapPush(max_heap, new_val);
        } else {
            heapPush(min_heap, new_val);
        }
        hashMapIncrement(new_val);

        // Remove old element
        int old_val = nums[i - k];
        hashMapDecrement(old_val);

        // Balance and clean heaps
        // Clean before balancing to remove invalid elements that might be at the top
        cleanHeaps(max_heap, min_heap); 
        balanceHeaps(max_heap, min_heap);
        // Clean again after balancing, as elements moved during balancing might now be at top and invalid
        cleanHeaps(max_heap, min_heap); 

        // Calculate median
        if (k % 2 == 1) {
            result[i - k + 1] = (double)heapPeek(max_heap);
        } else {
            result[i - k + 1] = ((double)heapPeek(max_heap) + (double)heapPeek(min_heap)) / 2.0;
        }
    }

    freeHeap(max_heap);
    freeHeap(min_heap);
    hashMapFree();

    return result;
}