#include <stdlib.h>
#include <string.h>
#include <limits.h>

typedef struct {
    long long freeTime;
    int serverId;
} ServerStatus;

typedef struct {
    ServerStatus* data;
    int capacity;
    int size;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (ServerStatus*)malloc(sizeof(ServerStatus) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void swap(ServerStatus* a, ServerStatus* b) {
    ServerStatus temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* heap, int idx) {
    int parent = (idx - 1) / 2;
    while (idx > 0 && heap->data[idx].freeTime < heap->data[parent].freeTime) {
        swap(&heap->data[idx], &heap->data[parent]);
        idx = parent;
        parent = (idx - 1) / 2;
    }
}

void heapifyDown(MinHeap* heap, int idx) {
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;
    int smallest = idx;

    if (left < heap->size && heap->data[left].freeTime < heap->data[smallest].freeTime) {
        smallest = left;
    }
    if (right < heap->size && heap->data[right].freeTime < heap->data[smallest].freeTime) {
        smallest = right;
    }

    if (smallest != idx) {
        swap(&heap->data[idx], &heap->data[smallest]);
        heapifyDown(heap, smallest);
    }
}

void insertMinHeap(MinHeap* heap, ServerStatus status) {
    heap->data[heap->size] = status;
    heapifyUp(heap, heap->size);
    heap->size++;
}

ServerStatus extractMin(MinHeap* heap) {
    ServerStatus root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return root;
}

int isMinHeapEmpty(MinHeap* heap) {
    return heap->size == 0;
}

void freeMinHeap(MinHeap* heap) {
    free(heap->data);
    free(heap);
}

int* seg_tree;
int K_servers_global; // Global K for segment tree operations

void build_seg_tree(int node, int start, int end) {
    if (start == end) {
        seg_tree[node] = 1; // Initially all servers are available
    } else {
        int mid = (start + end) / 2;
        build_seg_tree(2 * node, start, mid);
        build_seg_tree(2 * node + 1, mid + 1, end);
        seg_tree[node] = seg_tree[2 * node] + seg_tree[2 * node + 1]; // Sum of available servers
    }
}

void update_seg_tree(int node, int start, int end, int idx, int val) {
    if (start == end) {
        seg_tree[node] = val; // 0 for busy, 1 for available
    } else {
        int mid = (start + end) / 2;
        if (start <= idx && idx <= mid) {
            update_seg_tree(2 * node, start, mid, idx, val);
        } else {
            update_seg_tree(2 * node + 1, mid + 1, end, idx, val);
        }
        seg_tree[node] = seg_tree[2 * node] + seg_tree[2 * node + 1];
    }
}

int query_seg_tree(int node, int start, int end, int query_L, int query_R) {
    // If the current segment is outside the query range OR
    // If the current segment has no available servers (sum is 0)
    if (start > query_R || end < query_L || seg_tree[node] == 0) {
        return -1;
    }

    // If it's a leaf node and it's available (seg_tree[node] == 1), return its index
    if (start == end) {
        return start;
    }

    int mid = (start + end) / 2;
    int res = -1;

    // Check left child first, as we want the smallest index
    res = query_seg_tree(2 * node, start, mid, query_L, query_R);

    if (res != -1) { // Found in left child
        return res;
    }

    // If not found in left child, check right child
    res = query_seg_tree(2 * node + 1, mid + 1, end, query_L, query_R);

    return res;
}

int* busiestServers(int k, int* arrival, int n, int* load, int loadSize, int* returnSize) {
    K_servers_global = k; // Initialize global K_servers_global for segment tree

    // Allocate segment tree
    seg_tree = (int*)malloc(sizeof(int) * 4 * k);
    build_seg_tree(1, 0, k - 1); // All servers initially available

    // Request counts for each server
    int* request_counts = (int*)calloc(k, sizeof(int));

    // Min-Heap for busy servers (stores freeTime, serverId)
    MinHeap* busy_servers_heap = createMinHeap(k);

    for (int i = 0; i < n; ++i) {
        long long current_time = arrival[i];

        // 1. Release servers that are now free
        while (!isMinHeapEmpty(busy_servers_heap) && busy_servers_heap->data[0].freeTime <= current_time) {
            ServerStatus free_server = extractMin(busy_servers_heap);
            update_seg_tree(1, 0, k - 1, free_server.serverId, 1); // Mark as available
        }

        // 2. Find an available server
        int server_to_assign = -1;
        int start_server_id = i % k;

        // Try to find server j >= i % k
        server_to_assign = query_seg_tree(1, 0, k - 1, start_server_id, k - 1);

        if (server_to_assign == -1) {
            // If no server j >= i % k is available, try j < i % k
            server_to_assign = query_seg_tree(1, 0, k - 1, 0, start_server_id - 1);
        }

        if (server_to_assign != -1) {
            // Server found, assign request
            request_counts[server_to_assign]++;
            update_seg_tree(1, 0, k - 1, server_to_assign, 0); // Mark as busy

            ServerStatus new_busy_server = {current_time + load[i], server_to_assign};
            insertMinHeap(busy_servers_heap, new_busy_server);
        }
        // Else: request is dropped
    }

    // 3. Find servers that handled the maximum number of requests
    int max_requests = 0;
    for (int i = 0; i < k; ++i) {
        if (request_counts[i] > max_requests) {
            max_requests = request_counts[i];
        }
    }

    int* result = (int*)malloc(sizeof(int) * k); // Max k servers can be in result
    int count = 0;
    for (int i = 0; i < k; ++i) {
        if (request_counts[i] == max_requests) {
            result[count++] = i;
        }
    }

    *returnSize = count;

    // Clean up
    free(request_counts);
    freeMinHeap(busy_servers_heap);
    free(seg_tree);

    return result;
}