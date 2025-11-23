#include <stdlib.h> 

long long max(long long a, long long b) {
    return (a > b) ? a : b;
}

typedef struct {
    int weight;
    int index;
} ServerInfo;

typedef struct {
    ServerInfo* data;
    int size;
    int capacity;
} AvailableServerHeap;

void initAvailableServerHeap(AvailableServerHeap* heap, int capacity) {
    heap->data = (ServerInfo*)malloc(sizeof(ServerInfo) * capacity);
    heap->size = 0;
    heap->capacity = capacity;
}

void destroyAvailableServerHeap(AvailableServerHeap* heap) {
    free(heap->data);
    heap->data = NULL;
    heap->size = 0;
    heap->capacity = 0;
}

int compareServerInfo(const ServerInfo* a, const ServerInfo* b) {
    if (a->weight != b->weight) {
        return a->weight - b->weight;
    }
    return a->index - b->index;
}

void heapifyUpAvailable(AvailableServerHeap* heap, int idx) {
    while (idx > 0) {
        int parentIdx = (idx - 1) / 2;
        if (compareServerInfo(&heap->data[idx], &heap->data[parentIdx]) < 0) {
            ServerInfo temp = heap->data[idx];
            heap->data[idx] = heap->data[parentIdx];
            heap->data[parentIdx] = temp;
            idx = parentIdx;
        } else {
            break;
        }
    }
}

void heapifyDownAvailable(AvailableServerHeap* heap, int idx) {
    int smallest = idx;
    int leftChild = 2 * idx + 1;
    int rightChild = 2 * idx + 2;

    if (leftChild < heap->size && compareServerInfo(&heap->data[leftChild], &heap->data[smallest]) < 0) {
        smallest = leftChild;
    }
    if (rightChild < heap->size && compareServerInfo(&heap->data[rightChild], &heap->data[smallest]) < 0) {
        smallest = rightChild;
    }

    if (smallest != idx) {
        ServerInfo temp = heap->data[idx];
        heap->data[idx] = heap->data[smallest];
        heap->data[smallest] = temp;
        heapifyDownAvailable(heap, smallest);
    }
}

void pushAvailable(AvailableServerHeap* heap, ServerInfo server) {
    heap->data[heap->size] = server;
    heap->size++;
    heapifyUpAvailable(heap, heap->size - 1);
}

ServerInfo popAvailable(AvailableServerHeap* heap) {
    ServerInfo root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDownAvailable(heap, 0);
    return root;
}

ServerInfo topAvailable(AvailableServerHeap* heap) {
    return heap->data[0];
}

int isEmptyAvailable(AvailableServerHeap* heap) {
    return heap->size == 0;
}

typedef struct {
    long long finish_time;
    int weight;
    int index;
} BusyServerInfo;

typedef struct {
    BusyServerInfo* data;
    int size;
    int capacity;
} BusyServerHeap;

void initBusyServerHeap(BusyServerHeap* heap, int capacity) {
    heap->data = (BusyServerInfo*)malloc(sizeof(BusyServerInfo) * capacity);
    heap->size = 0;
    heap->capacity = capacity;
}

void destroyBusyServerHeap(BusyServerHeap* heap) {
    free(heap->data);
    heap->data = NULL;
    heap->size = 0;
    heap->capacity = 0;
}

int compareBusyServerInfo(const BusyServerInfo* a, const BusyServerInfo* b) {
    if (a->finish_time != b->finish_time) {
        return (a->finish_time < b->finish_time) ? -1 : 1;
    }
    if (a->weight != b->weight) {
        return a->weight - b->weight;
    }
    return a->index - b->index;
}

void heapifyUpBusy(BusyServerHeap* heap, int idx) {
    while (idx > 0) {
        int parentIdx = (idx - 1) / 2;
        if (compareBusyServerInfo(&heap->data[idx], &heap->data[parentIdx]) < 0) {
            BusyServerInfo temp = heap->data[idx];
            heap->data[idx] = heap->data[parentIdx];
            heap->data[parentIdx] = temp;
            idx = parentIdx;
        } else {
            break;
        }
    }
}

void heapifyDownBusy(BusyServerHeap* heap, int idx) {
    int smallest = idx;
    int leftChild = 2 * idx + 1;
    int rightChild = 2 * idx + 2;

    if (leftChild < heap->size && compareBusyServerInfo(&heap->data[leftChild], &heap->data[smallest]) < 0) {
        smallest = leftChild;
    }
    if (rightChild < heap->size && compareBusyServerInfo(&heap->data[rightChild], &heap->data[smallest]) < 0) {
        smallest = rightChild;
    }

    if (smallest != idx) {
        BusyServerInfo temp = heap->data[idx];
        heap->data[idx] = heap->data[smallest];
        heap->data[smallest] = temp;
        heapifyDownBusy(heap, smallest);
    }
}

void pushBusy(BusyServerHeap* heap, BusyServerInfo server) {
    heap->data[heap->size] = server;
    heap->size++;
    heapifyUpBusy(heap, heap->size - 1);
}

BusyServerInfo popBusy(BusyServerHeap* heap) {
    BusyServerInfo root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDownBusy(heap, 0);
    return root;
}

BusyServerInfo topBusy(BusyServerHeap* heap) {
    return heap->data[0];
}

int isEmptyBusy(BusyServerHeap* heap) {
    return heap->size == 0;
}

int* assignTasks(int* servers, int serversSize, int* tasks, int tasksSize, int* returnSize) {
    *returnSize = tasksSize;
    int* ans = (int*)malloc(sizeof(int) * tasksSize);

    AvailableServerHeap availableServers;
    initAvailableServerHeap(&availableServers, serversSize);

    BusyServerHeap busyServers;
    initBusyServerHeap(&busyServers, serversSize);

    // Initialize available servers heap
    for (int i = 0; i < serversSize; ++i) {
        ServerInfo s = {servers[i], i};
        pushAvailable(&availableServers, s);
    }

    long long currentTime = 0; // Represents the current simulation time

    for (int taskIdx = 0; taskIdx < tasksSize; ++taskIdx) {
        // 1. Advance simulation time to at least the current task's arrival time.
        //    This is the earliest time we can *consider* processing taskIdx.
        currentTime = max(currentTime, (long long)taskIdx);

        // 2. Release any servers that finished their tasks by this `currentTime`.
        while (!isEmptyBusy(&busyServers) && topBusy(&busyServers).finish_time <= currentTime) {
            BusyServerInfo busy = popBusy(&busyServers);
            ServerInfo s = {busy.weight, busy.index};
            pushAvailable(&availableServers, s);
        }

        // 3. If no servers are available, we must wait for one to finish.
        //    Advance `currentTime` to the finish time of the earliest busy server.
        //    Then, release any servers that finish by this new `currentTime`.
        if (isEmptyAvailable(&availableServers)) {
            currentTime = topBusy(&busyServers).finish_time;

            // Release servers that finish by this new `currentTime`.
            while (!isEmptyBusy(&busyServers) && topBusy(&busyServers).finish_time <= currentTime) {
                BusyServerInfo busy = popBusy(&busyServers);
                ServerInfo s = {busy.weight, busy.index};
                pushAvailable(&availableServers, s);
            }
        }

        // 4. At this point, `availableServers` is guaranteed to be non-empty.
        //    Pick the best available server.
        ServerInfo assignedServer = popAvailable(&availableServers);
        ans[taskIdx] = assignedServer.index;

        // 5. Assign the task to this server and mark it as busy.
        BusyServerInfo newBusyServer = {
            .finish_time = currentTime + tasks[taskIdx],
            .weight = assignedServer.weight,
            .index = assignedServer.index
        };
        pushBusy(&busyServers, newBusyServer);
    }

    destroyAvailableServerHeap(&availableServers);
    destroyBusyServerHeap(&busyServers);

    return ans;
}