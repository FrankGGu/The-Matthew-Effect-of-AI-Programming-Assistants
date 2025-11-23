typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} HashItem;

typedef struct {
    int* heap;
    int size;
    int capacity;
} Heap;

void swap(int* a, int* b) {
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

void heapPush(Heap* obj, int x) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->heap = realloc(obj->heap, sizeof(int) * obj->capacity);
    }
    obj->heap[obj->size++] = x;
    int i = obj->size - 1;
    while (i > 0 && obj->heap[i] < obj->heap[(i - 1) / 2]) {
        swap(&obj->heap[i], &obj->heap[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}

int heapPop(Heap* obj) {
    int ret = obj->heap[0];
    obj->heap[0] = obj->heap[--obj->size];
    int i = 0;
    while (1) {
        int left = 2 * i + 1, right = 2 * i + 2, min = i;
        if (left < obj->size && obj->heap[left] < obj->heap[min]) min = left;
        if (right < obj->size && obj->heap[right] < obj->heap[min]) min = right;
        if (min == i) break;
        swap(&obj->heap[i], &obj->heap[min]);
        i = min;
    }
    return ret;
}

int heapTop(Heap* obj) {
    return obj->heap[0];
}

Heap* heapCreate() {
    Heap* obj = malloc(sizeof(Heap));
    obj->size = 0;
    obj->capacity = 8;
    obj->heap = malloc(sizeof(int) * obj->capacity);
    return obj;
}

void heapFree(Heap* obj) {
    free(obj->heap);
    free(obj);
}

int* busiestServers(int k, int* arrival, int arrivalSize, int* load, int loadSize, int* returnSize) {
    int* count = calloc(k, sizeof(int));
    Heap* busy = heapCreate();
    Heap* free = heapCreate();
    for (int i = 0; i < k; i++) {
        heapPush(free, i);
    }

    for (int i = 0; i < arrivalSize; i++) {
        int start = arrival[i];
        while (busy->size > 0 && heapTop(busy) <= start) {
            int server = heapPop(busy);
            heapPush(free, i + ((server - i) % k + k) % k);
        }
        if (free->size == 0) continue;
        int pos = heapPop(free) % k;
        count[pos]++;
        heapPush(busy, start + load[i]);
    }

    int max = 0;
    for (int i = 0; i < k; i++) {
        if (count[i] > max) max = count[i];
    }
    int* res = malloc(k * sizeof(int));
    int idx = 0;
    for (int i = 0; i < k; i++) {
        if (count[i] == max) {
            res[idx++] = i;
        }
    }
    *returnSize = idx;
    free(count);
    heapFree(busy);
    heapFree(free);
    return res;
}