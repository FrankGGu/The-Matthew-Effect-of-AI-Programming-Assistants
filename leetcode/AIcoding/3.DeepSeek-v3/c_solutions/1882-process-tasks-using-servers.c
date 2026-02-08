typedef struct {
    int weight;
    int index;
    long long available_time;
} Server;

typedef struct {
    Server* data;
    int size;
    int capacity;
} MinHeap;

typedef struct {
    Server* data;
    int size;
    int capacity;
} AvailableHeap;

void swap(Server* a, Server* b) {
    Server temp = *a;
    *a = *b;
    *b = temp;
}

void minHeapify(MinHeap* heap, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < heap->size && 
        (heap->data[left].available_time < heap->data[smallest].available_time ||
         (heap->data[left].available_time == heap->data[smallest].available_time && 
          heap->data[left].index < heap->data[smallest].index))) {
        smallest = left;
    }

    if (right < heap->size && 
        (heap->data[right].available_time < heap->data[smallest].available_time ||
         (heap->data[right].available_time == heap->data[smallest].available_time && 
          heap->data[right].index < heap->data[smallest].index))) {
        smallest = right;
    }

    if (smallest != idx) {
        swap(&heap->data[idx], &heap->data[smallest]);
        minHeapify(heap, smallest);
    }
}

void availableHeapify(AvailableHeap* heap, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < heap->size && 
        (heap->data[left].weight < heap->data[smallest].weight ||
         (heap->data[left].weight == heap->data[smallest].weight && 
          heap->data[left].index < heap->data[smallest].index))) {
        smallest = left;
    }

    if (right < heap->size && 
        (heap->data[right].weight < heap->data[smallest].weight ||
         (heap->data[right].weight == heap->data[smallest].weight && 
          heap->data[right].index < heap->data[smallest].index))) {
        smallest = right;
    }

    if (smallest != idx) {
        swap(&heap->data[idx], &heap->data[smallest]);
        availableHeapify(heap, smallest);
    }
}

void pushAvailable(AvailableHeap* heap, Server server) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = realloc(heap->data, heap->capacity * sizeof(Server));
    }
    heap->data[heap->size] = server;
    int i = heap->size;
    heap->size++;

    while (i > 0) {
        int parent = (i - 1) / 2;
        if (heap->data[parent].weight < heap->data[i].weight ||
            (heap->data[parent].weight == heap->data[i].weight && 
             heap->data[parent].index < heap->data[i].index)) {
            break;
        }
        swap(&heap->data[i], &heap->data[parent]);
        i = parent;
    }
}

Server popAvailable(AvailableHeap* heap) {
    Server result = heap->data[0];
    heap->size--;
    heap->data[0] = heap->data[heap->size];
    availableHeapify(heap, 0);
    return result;
}

void pushBusy(MinHeap* heap, Server server) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = realloc(heap->data, heap->capacity * sizeof(Server));
    }
    heap->data[heap->size] = server;
    int i = heap->size;
    heap->size++;

    while (i > 0) {
        int parent = (i - 1) / 2;
        if (heap->data[parent].available_time < heap->data[i].available_time ||
            (heap->data[parent].available_time == heap->data[i].available_time && 
             heap->data[parent].index < heap->data[i].index)) {
            break;
        }
        swap(&heap->data[i], &heap->data[parent]);
        i = parent;
    }
}

Server popBusy(MinHeap* heap) {
    Server result = heap->data[0];
    heap->size--;
    heap->data[0] = heap->data[heap->size];
    minHeapify(heap, 0);
    return result;
}

int* assignTasks(int* servers, int serversSize, int* tasks, int tasksSize, int* returnSize) {
    AvailableHeap available = {0};
    available.capacity = serversSize;
    available.data = malloc(available.capacity * sizeof(Server));
    available.size = 0;

    MinHeap busy = {0};
    busy.capacity = serversSize;
    busy.data = malloc(busy.capacity * sizeof(Server));
    busy.size = 0;

    for (int i = 0; i < serversSize; i++) {
        Server server = {servers[i], i, 0};
        pushAvailable(&available, server);
    }

    int* result = malloc(tasksSize * sizeof(int));
    *returnSize = tasksSize;

    long long current_time = 0;

    for (int i = 0; i < tasksSize; i++) {
        current_time = (current_time > i) ? current_time : i;

        while (busy.size > 0 && busy.data[0].available_time <= current_time) {
            Server freed = popBusy(&busy);
            pushAvailable(&available, freed);
        }

        if (available.size == 0) {
            current_time = busy.data[0].available_time;
            while (busy.size > 0 && busy.data[0].available_time <= current_time) {
                Server freed = popBusy(&busy);
                pushAvailable(&available, freed);
            }
        }

        Server assigned = popAvailable(&available);
        result[i] = assigned.index;
        assigned.available_time = current_time + tasks[i];
        pushBusy(&busy, assigned);
    }

    free(available.data);
    free(busy.data);

    return result;
}