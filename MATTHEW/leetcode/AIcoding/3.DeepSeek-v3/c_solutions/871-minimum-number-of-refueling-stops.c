typedef long long ll;

typedef struct {
    int station;
    int fuel;
} HeapNode;

typedef struct {
    HeapNode* data;
    int size;
    int capacity;
} MaxHeap;

MaxHeap* createHeap(int capacity) {
    MaxHeap* heap = (MaxHeap*)malloc(sizeof(MaxHeap));
    heap->data = (HeapNode*)malloc(capacity * sizeof(HeapNode));
    heap->size = 0;
    heap->capacity = capacity;
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
        if (heap->data[parent].fuel >= heap->data[idx].fuel) break;
        swap(&heap->data[parent], &heap->data[idx]);
        idx = parent;
    }
}

void heapifyDown(MaxHeap* heap, int idx) {
    while (1) {
        int left = 2 * idx + 1;
        int right = 2 * idx + 2;
        int largest = idx;

        if (left < heap->size && heap->data[left].fuel > heap->data[largest].fuel) {
            largest = left;
        }
        if (right < heap->size && heap->data[right].fuel > heap->data[largest].fuel) {
            largest = right;
        }
        if (largest == idx) break;

        swap(&heap->data[idx], &heap->data[largest]);
        idx = largest;
    }
}

void push(MaxHeap* heap, int station, int fuel) {
    if (heap->size == heap->capacity) return;
    heap->data[heap->size].station = station;
    heap->data[heap->size].fuel = fuel;
    heapifyUp(heap, heap->size);
    heap->size++;
}

HeapNode pop(MaxHeap* heap) {
    HeapNode result = heap->data[0];
    heap->size--;
    heap->data[0] = heap->data[heap->size];
    heapifyDown(heap, 0);
    return result;
}

int minRefuelStops(int target, int startFuel, int** stations, int stationsSize, int* stationsColSize) {
    if (startFuel >= target) return 0;

    MaxHeap* heap = createHeap(stationsSize);
    int stops = 0;
    ll currentFuel = startFuel;
    int i = 0;

    while (currentFuel < target) {
        while (i < stationsSize && stations[i][0] <= currentFuel) {
            push(heap, stations[i][0], stations[i][1]);
            i++;
        }

        if (heap->size == 0) return -1;

        HeapNode maxStation = pop(heap);
        currentFuel += maxStation.fuel;
        stops++;

        if (currentFuel >= target) break;
    }

    free(heap->data);
    free(heap);

    return stops;
}