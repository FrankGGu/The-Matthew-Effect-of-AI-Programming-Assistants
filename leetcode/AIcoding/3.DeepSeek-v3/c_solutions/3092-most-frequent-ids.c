typedef struct {
    long long key;
    long long freq;
    UT_hash_handle hh;
} FreqMap;

typedef struct {
    long long id;
    long long freq;
} HeapNode;

typedef struct {
    HeapNode* arr;
    int capacity;
    int size;
} MaxHeap;

MaxHeap* createHeap(int capacity) {
    MaxHeap* heap = (MaxHeap*)malloc(sizeof(MaxHeap));
    heap->arr = (HeapNode*)malloc(capacity * sizeof(HeapNode));
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void swap(HeapNode* a, HeapNode* b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MaxHeap* heap, int idx) {
    while (idx > 0) {
        int parent = (idx - 1) / 2;
        if (heap->arr[parent].freq >= heap->arr[idx].freq) break;
        swap(&heap->arr[parent], &heap->arr[idx]);
        idx = parent;
    }
}

void heapifyDown(MaxHeap* heap, int idx) {
    while (1) {
        int left = 2 * idx + 1;
        int right = 2 * idx + 2;
        int largest = idx;

        if (left < heap->size && heap->arr[left].freq > heap->arr[largest].freq) {
            largest = left;
        }
        if (right < heap->size && heap->arr[right].freq > heap->arr[largest].freq) {
            largest = right;
        }
        if (largest == idx) break;
        swap(&heap->arr[idx], &heap->arr[largest]);
        idx = largest;
    }
}

void push(MaxHeap* heap, long long id, long long freq) {
    if (heap->size == heap->capacity) return;
    heap->arr[heap->size].id = id;
    heap->arr[heap->size].freq = freq;
    heap->size++;
    heapifyUp(heap, heap->size - 1);
}

HeapNode pop(MaxHeap* heap) {
    HeapNode root = heap->arr[0];
    heap->arr[0] = heap->arr[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return root;
}

long long* mostFrequentIDs(int* nums, int numsSize, int* freq, int freqSize, int* returnSize) {
    *returnSize = numsSize;
    long long* ans = (long long*)malloc(numsSize * sizeof(long long));
    FreqMap* map = NULL;
    MaxHeap* heap = createHeap(numsSize);

    for (int i = 0; i < numsSize; i++) {
        long long id = nums[i];
        long long change = freq[i];

        FreqMap* entry = NULL;
        HASH_FIND_INT(map, &id, entry);
        if (!entry) {
            entry = (FreqMap*)malloc(sizeof(FreqMap));
            entry->key = id;
            entry->freq = 0;
            HASH_ADD_INT(map, key, entry);
        }
        entry->freq += change;

        if (entry->freq == 0) {
            HASH_DEL(map, entry);
            free(entry);
        } else {
            push(heap, id, entry->freq);
        }

        while (heap->size > 0) {
            HeapNode top = heap->arr[0];
            FreqMap* check = NULL;
            HASH_FIND_INT(map, &top.id, check);
            if (check && check->freq == top.freq) {
                ans[i] = top.freq;
                break;
            } else {
                pop(heap);
            }
        }
        if (heap->size == 0) {
            ans[i] = 0;
        }
    }

    FreqMap *current, *tmp;
    HASH_ITER(hh, map, current, tmp) {
        HASH_DEL(map, current);
        free(current);
    }
    free(heap->arr);
    free(heap);

    return ans;
}