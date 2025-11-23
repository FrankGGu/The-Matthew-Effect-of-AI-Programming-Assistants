typedef struct {
    int* heap;
    int size;
    int capacity;
} SeatManager;

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(SeatManager* obj, int index) {
    if (index == 0) return;
    int parent = (index - 1) / 2;
    if (obj->heap[parent] > obj->heap[index]) {
        swap(&obj->heap[parent], &obj->heap[index]);
        heapifyUp(obj, parent);
    }
}

void heapifyDown(SeatManager* obj, int index) {
    int left = 2 * index + 1;
    int right = 2 * index + 2;
    int smallest = index;

    if (left < obj->size && obj->heap[left] < obj->heap[smallest]) {
        smallest = left;
    }
    if (right < obj->size && obj->heap[right] < obj->heap[smallest]) {
        smallest = right;
    }
    if (smallest != index) {
        swap(&obj->heap[index], &obj->heap[smallest]);
        heapifyDown(obj, smallest);
    }
}

SeatManager* seatManagerCreate(int n) {
    SeatManager* obj = (SeatManager*)malloc(sizeof(SeatManager));
    obj->capacity = n;
    obj->size = n;
    obj->heap = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        obj->heap[i] = i + 1;
    }
    return obj;
}

int seatManagerReserve(SeatManager* obj) {
    int seat = obj->heap[0];
    obj->heap[0] = obj->heap[obj->size - 1];
    obj->size--;
    heapifyDown(obj, 0);
    return seat;
}

void seatManagerUnreserve(SeatManager* obj, int seatNumber) {
    obj->heap[obj->size] = seatNumber;
    obj->size++;
    heapifyUp(obj, obj->size - 1);
}

void seatManagerFree(SeatManager* obj) {
    free(obj->heap);
    free(obj);
}

/**
 * Your SeatManager struct will be instantiated and called as such:
 * SeatManager* obj = seatManagerCreate(n);
 * int param_1 = seatManagerReserve(obj);
 * seatManagerUnreserve(obj, seatNumber);
 * seatManagerFree(obj);
 */