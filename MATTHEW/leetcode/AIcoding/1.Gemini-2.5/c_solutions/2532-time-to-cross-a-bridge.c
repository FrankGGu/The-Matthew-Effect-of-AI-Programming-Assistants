#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

typedef struct {
    long long time;
    int id;
} HeapNode;

typedef struct {
    HeapNode* nodes;
    int capacity;
    int size;
    bool (*compare)(HeapNode a, HeapNode b);
} MinHeap;

bool default_min_compare(HeapNode a, HeapNode b) {
    if (a.time != b.time) {
        return a.time < b.time;
    }
    return a.id < b.id;
}

bool max_priority_compare(HeapNode a, HeapNode b) {
    if (a.time != b.time) {
        return a.time < b.time;
    }
    return a.id < b.id;
}

MinHeap* createHeap(int capacity, bool (*comp_func)(HeapNode, HeapNode)) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->nodes = (HeapNode*)malloc(sizeof(HeapNode) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
    heap->compare = comp_func;
    return heap;
}

void destroyHeap(MinHeap* heap) {
    free(heap->nodes);
    free(heap);
}

void heapifyUp(MinHeap* heap, int idx) {
    while (idx > 0) {
        int parentIdx = (idx - 1) / 2;
        if (heap->compare(heap->nodes[idx], heap->nodes[parentIdx])) {
            HeapNode temp = heap->nodes[idx];
            heap->nodes[idx] = heap->nodes[parentIdx];
            heap->nodes[parentIdx] = temp;
            idx = parentIdx;
        } else {
            break;
        }
    }
}

void heapifyDown(MinHeap* heap, int idx) {
    while (true) {
        int leftChildIdx = 2 * idx + 1;
        int rightChildIdx = 2 * idx + 2;
        int prioritizedChildIdx = idx;

        if (leftChildIdx < heap->size && heap->compare(heap->nodes[leftChildIdx], heap->nodes[prioritizedChildIdx])) {
            prioritizedChildIdx = leftChildIdx;
        }
        if (rightChildIdx < heap->size && heap->compare(heap->nodes[rightChildIdx], heap->nodes[prioritizedChildIdx])) {
            prioritizedChildIdx = rightChildIdx;
        }

        if (prioritizedChildIdx != idx) {
            HeapNode temp = heap->nodes[idx];
            heap->nodes[idx] = heap->nodes[prioritizedChildIdx];
            heap->nodes[prioritizedChildIdx] = temp;
            idx = prioritizedChildIdx;
        } else {
            break;
        }
    }
}

void heapPush(MinHeap* heap, HeapNode node) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->nodes = (HeapNode*)realloc(heap->nodes, sizeof(HeapNode) * heap->capacity);
    }
    heap->nodes[heap->size++] = node;
    heapifyUp(heap, heap->size - 1);
}

HeapNode heapPop(MinHeap* heap) {
    if (heap->size == 0) {
        return (HeapNode){LLONG_MAX, -1};
    }
    HeapNode root = heap->nodes[0];
    heap->nodes[0] = heap->nodes[--heap->size];
    heapifyDown(heap, 0);
    return root;
}

HeapNode heapPeek(MinHeap* heap) {
    if (heap->size == 0) {
        return (HeapNode){LLONG_MAX, -1};
    }
    return heap->nodes[0];
}

bool heapIsEmpty(MinHeap* heap) {
    return heap->size == 0;
}

long long findCrossingTime(int k, int n, int** time) {
    long long currentTime = 0;
    int boxesCollected = 0;
    long long maxFinishTime = 0;

    MinHeap* waitingLeft = createHeap(n + 1, max_priority_compare);
    MinHeap* waitingRight = createHeap(n + 1, max_priority_compare);
    MinHeap* crossingLeft = createHeap(n + 1, default_min_compare);
    MinHeap* crossingRight = createHeap(n + 1, default_min_compare);

    for (int i = 0; i < n; ++i) {
        heapPush(waitingLeft, (HeapNode){(long long)-time[i][0], -i});
    }

    while (boxesCollected < k || !heapIsEmpty(crossingLeft) || !heapIsEmpty(crossingRight)) {
        while (!heapIsEmpty(crossingLeft) && heapPeek(crossingLeft).time <= currentTime) {
            HeapNode worker = heapPop(crossingLeft);
            heapPush(waitingRight, (HeapNode){(long long)-time[worker.id][1], -worker.id});
        }
        while (!heapIsEmpty(crossingRight) && heapPeek(crossingRight).time <= currentTime) {
            HeapNode worker = heapPop(crossingRight);
            heapPush(waitingLeft, (HeapNode){(long long)-time[worker.id][0], -worker.id});
        }

        bool bridgeUsed = false;
        if (!heapIsEmpty(waitingRight)) {
            HeapNode worker = heapPop(waitingRight);
            int workerId = -worker.id;
            currentTime += time[workerId][1];
            heapPush(crossingRight, (HeapNode){currentTime + time[workerId][2], workerId});
            bridgeUsed = true;
        } else if (boxesCollected < k && !heapIsEmpty(waitingLeft)) {
            HeapNode worker = heapPop(waitingLeft);
            int workerId = -worker.id;
            currentTime += time[workerId][0];
            boxesCollected++;
            if (currentTime + time[workerId][3] > maxFinishTime) {
                maxFinishTime = currentTime + time[workerId][3];
            }
            heapPush(crossingLeft, (HeapNode){currentTime + time[workerId][3], workerId});
            bridgeUsed = true;
        }

        if (!bridgeUsed) {
            long long nextAvailableTime = LLONG_MAX;
            if (!heapIsEmpty(crossingLeft)) {
                if (heapPeek(crossingLeft).time < nextAvailableTime) {
                    nextAvailableTime = heapPeek(crossingLeft).time;
                }
            }
            if (!heapIsEmpty(crossingRight)) {
                if (heapPeek(crossingRight).time < nextAvailableTime) {
                    nextAvailableTime = heapPeek(crossingRight).time;
                }
            }

            if (nextAvailableTime == LLONG_MAX) {
                break;
            }

            if (nextAvailableTime > currentTime) {
                currentTime = nextAvailableTime;
            }
        }
    }

    destroyHeap(waitingLeft);
    destroyHeap(waitingRight);
    destroyHeap(crossingLeft);
    destroyHeap(crossingRight);

    return maxFinishTime;
}