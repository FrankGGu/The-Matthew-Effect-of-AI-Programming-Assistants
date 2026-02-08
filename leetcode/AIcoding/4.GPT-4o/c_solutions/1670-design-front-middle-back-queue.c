typedef struct {
    int *data;
    int front;
    int middle;
    int back;
    int size;
    int capacity;
} FrontMiddleBackQueue;

FrontMiddleBackQueue* frontMiddleBackQueueCreate() {
    FrontMiddleBackQueue* queue = (FrontMiddleBackQueue*)malloc(sizeof(FrontMiddleBackQueue));
    queue->capacity = 1000;
    queue->data = (int*)malloc(queue->capacity * sizeof(int));
    queue->front = 0;
    queue->middle = 0;
    queue->back = 0;
    queue->size = 0;
    return queue;
}

void frontMiddleBackQueuePushFront(FrontMiddleBackQueue* obj, int value) {
    if (obj->size < obj->capacity) {
        obj->front = (obj->front - 1 + obj->capacity) % obj->capacity;
        obj->data[obj->front] = value;
        obj->size++;
        obj->middle = (obj->front + obj->size / 2) % obj->capacity;
    }
}

void frontMiddleBackQueuePushMiddle(FrontMiddleBackQueue* obj, int value) {
    if (obj->size < obj->capacity) {
        if (obj->size % 2 == 0) {
            obj->back = (obj->back - 1 + obj->capacity) % obj->capacity;
            obj->data[obj->back] = obj->data[obj->middle];
            obj->middle = (obj->middle - 1 + obj->capacity) % obj->capacity;
        }
        obj->data[obj->middle] = value;
        obj->size++;
        obj->middle = (obj->middle + 1) % obj->capacity;
    }
}

void frontMiddleBackQueuePushBack(FrontMiddleBackQueue* obj, int value) {
    if (obj->size < obj->capacity) {
        obj->data[obj->back] = value;
        obj->back = (obj->back + 1) % obj->capacity;
        obj->size++;
        obj->middle = (obj->front + obj->size / 2) % obj->capacity;
    }
}

int frontMiddleBackQueuePopFront(FrontMiddleBackQueue* obj) {
    if (obj->size == 0) return -1;
    int value = obj->data[obj->front];
    obj->front = (obj->front + 1) % obj->capacity;
    obj->size--;
    obj->middle = (obj->front + obj->size / 2) % obj->capacity;
    return value;
}

int frontMiddleBackQueuePopMiddle(FrontMiddleBackQueue* obj) {
    if (obj->size == 0) return -1;
    int value = obj->data[obj->middle];
    if (obj->size % 2 == 0) {
        obj->middle = (obj->middle - 1 + obj->capacity) % obj->capacity;
    } else {
        obj->middle = (obj->middle + 1) % obj->capacity;
    }
    obj->size--;
    obj->front = (obj->front + (obj->size % 2 == 0 ? 0 : 1)) % obj->capacity;
    return value;
}

int frontMiddleBackQueuePopBack(FrontMiddleBackQueue* obj) {
    if (obj->size == 0) return -1;
    obj->back = (obj->back - 1 + obj->capacity) % obj->capacity;
    int value = obj->data[obj->back];
    obj->size--;
    obj->middle = (obj->front + obj->size / 2) % obj->capacity;
    return value;
}

void frontMiddleBackQueueFree(FrontMiddleBackQueue* obj) {
    free(obj->data);
    free(obj);
}