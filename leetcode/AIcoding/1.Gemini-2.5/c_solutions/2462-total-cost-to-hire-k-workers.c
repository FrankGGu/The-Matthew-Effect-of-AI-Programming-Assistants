#include <stdlib.h>
#include <limits.h>

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void min_heapify_down(int* heap, int size, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < size && heap[left] < heap[smallest]) {
        smallest = left;
    }
    if (right < size && heap[right] < heap[smallest]) {
        smallest = right;
    }

    if (smallest != idx) {
        swap(&heap[idx], &heap[smallest]);
        min_heapify_down(heap, size, smallest);
    }
}

void min_heapify_up(int* heap, int idx) {
    while (idx > 0 && heap[idx] < heap[(idx - 1) / 2]) {
        swap(&heap[idx], &heap[(idx - 1) / 2]);
        idx = (idx - 1) / 2;
    }
}

void heap_push(int* heap, int* size, int val) {
    heap[*size] = val;
    (*size)++;
    min_heapify_up(heap, *size - 1);
}

int heap_pop(int* heap, int* size) {
    int root = heap[0];
    heap[0] = heap[*size - 1];
    (*size)--;
    if (*size > 0) {
        min_heapify_down(heap, *size, 0);
    }
    return root;
}

int heap_top(int* heap) {
    return heap[0];
}

int heap_is_empty(int size) {
    return size == 0;
}

long long totalCost(int* costs, int costsSize, int k, int candidates1, int candidates2) {
    long long total_cost = 0;

    int pq1[100005];
    int pq2[100005];
    int pq1_size = 0;
    int pq2_size = 0;

    int left = 0;
    int right = costsSize - 1;

    for (int i = 0; i < candidates1; ++i) {
        if (left <= right) {
            heap_push(pq1, &pq1_size, costs[left++]);
        } else {
            break;
        }
    }

    for (int i = 0; i < candidates2; ++i) {
        if (left <= right) {
            heap_push(pq2, &pq2_size, costs[right--]);
        } else {
            break;
        }
    }

    for (int i = 0; i < k; ++i) {
        int val1 = heap_is_empty(pq1_size) ? INT_MAX : heap_top(pq1);
        int val2 = heap_is_empty(pq2_size) ? INT_MAX : heap_top(pq2);

        if (val1 <= val2) {
            total_cost += heap_pop(pq1, &pq1_size);
            if (left <= right) {
                heap_push(pq1, &pq1_size, costs[left++]);
            }
        } else {
            total_cost += heap_pop(pq2, &pq2_size);
            if (left <= right) {
                heap_push(pq2, &pq2_size, costs[right--]);
            }
        }
    }

    return total_cost;
}