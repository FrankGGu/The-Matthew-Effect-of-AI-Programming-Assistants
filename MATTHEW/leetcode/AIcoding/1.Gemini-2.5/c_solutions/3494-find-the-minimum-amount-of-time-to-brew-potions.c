#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

int compareDescending(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

typedef struct {
    long long *data;
    int size;
    int capacity;
} MinHeap;

void swap(long long *a, long long *b) {
    long long temp = *a;
    *a = *b;
    *b = temp;
}

void heapify_down(MinHeap *heap, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < heap->size && heap->data[left] < heap->data[smallest]) {
        smallest = left;
    }
    if (right < heap->size && heap->data[right] < heap->data[smallest]) {
        smallest = right;
    }

    if (smallest != idx) {
        swap(&heap->data[idx], &heap->data[smallest]);
        heapify_down(heap, smallest);
    }
}

void heap_init(MinHeap *heap, int capacity) {
    heap->data = (long long *)malloc(sizeof(long long) * capacity);
    for (int i = 0; i < capacity; ++i) {
        heap->data[i] = 0;
    }
    heap->size = capacity;
    heap->capacity = capacity;
}

void heap_free(MinHeap *heap) {
    free(heap->data);
    heap->data = NULL;
    heap->size = 0;
    heap->capacity = 0;
}

long long heap_peek_min(MinHeap *heap) {
    if (heap->size == 0) {
        return LLONG_MAX;
    }
    return heap->data[0];
}

void heap_update_min(MinHeap *heap, long long new_val) {
    if (heap->size == 0) {
        return;
    }
    heap->data[0] = new_val;
    heapify_down(heap, 0);
}

bool check(long long max_time, int* time, int timeSize, int k) {
    if (k == 0 && timeSize > 0) return false;
    if (timeSize == 0) return true;

    int* sorted_time = (int*)malloc(sizeof(int) * timeSize);
    memcpy(sorted_time, time, sizeof(int) * timeSize);
    qsort(sorted_time, timeSize, sizeof(int), compareDescending);

    MinHeap heap;
    heap_init(&heap, k);

    for (int i = 0; i < timeSize; ++i) {
        long long current_potion_duration = sorted_time[i];
        long long earliest_pot_finish_time = heap_peek_min(&heap);

        if (earliest_pot_finish_time + current_potion_duration > max_time) {
            free(sorted_time);
            heap_free(&heap);
            return false;
        }
        heap_update_min(&heap, earliest_pot_finish_time + current_potion_duration);
    }

    free(sorted_time);
    heap_free(&heap);
    return true;
}

long long findMinimumTime(int* potions, int potionsSize, int* time, int timeSize, int k) {
    if (timeSize == 0) return 0;

    long long low = 0;
    long long high = 0;
    int max_single_time = 0;

    for (int i = 0; i < timeSize; ++i) {
        high += time[i];
        if (time[i] > max_single_time) {
            max_single_time = time[i];
        }
    }
    low = max_single_time;

    if (k >= timeSize) {
        return max_single_time;
    }

    long long ans = high;

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        if (check(mid, time, timeSize, k)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
}