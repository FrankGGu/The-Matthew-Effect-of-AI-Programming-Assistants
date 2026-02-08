#include <stdbool.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int size;
    int capacity;
} MinHeap;

void heap_init(MinHeap* heap, int capacity) {
    heap->data = (int*)malloc(sizeof(int) * capacity);
    heap->size = 0;
    heap->capacity = capacity;
}

void heap_destroy(MinHeap* heap) {
    if (heap->data != NULL) {
        free(heap->data);
        heap->data = NULL;
    }
}

void heap_swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heap_bubble_up(MinHeap* heap, int idx) {
    int parent_idx = (idx - 1) / 2;
    while (idx > 0 && heap->data[idx] < heap->data[parent_idx]) {
        heap_swap(&heap->data[idx], &heap->data[parent_idx]);
        idx = parent_idx;
        parent_idx = (idx - 1) / 2;
    }
}

void heap_bubble_down(MinHeap* heap, int idx) {
    int left_child_idx = 2 * idx + 1;
    int right_child_idx = 2 * idx + 2;
    int smallest_idx = idx;

    if (left_child_idx < heap->size && heap->data[left_child_idx] < heap->data[smallest_idx]) {
        smallest_idx = left_child_idx;
    }
    if (right_child_idx < heap->size && heap->data[right_child_idx] < heap->data[smallest_idx]) {
        smallest_idx = right_child_idx;
    }

    if (smallest_idx != idx) {
        heap_swap(&heap->data[idx], &heap->data[smallest_idx]);
        heap_bubble_down(heap, smallest_idx);
    }
}

void heap_insert(MinHeap* heap, int val) {
    if (heap->size == heap->capacity) {
        return;
    }
    heap->data[heap->size] = val;
    heap->size++;
    heap_bubble_up(heap, heap->size - 1);
}

int heap_extract_min(MinHeap* heap) {
    if (heap->size == 0) {
        return -1;
    }
    int min_val = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heap_bubble_down(heap, 0);
    return min_val;
}

int furthestBuilding(int* heights, int heightsSize, int bricks, int ladders) {
    MinHeap minHeap;

    if (ladders > 0) {
        heap_init(&minHeap, ladders);
    } else {
        minHeap.data = NULL;
        minHeap.size = 0;
        minHeap.capacity = 0;
    }

    for (int i = 0; i < heightsSize - 1; ++i) {
        int diff = heights[i+1] - heights[i];

        if (diff <= 0) {
            continue;
        }

        if (ladders > 0) {
            heap_insert(&minHeap, diff);
            if (minHeap.size > ladders) {
                int smallest_ladder_eligible_jump = heap_extract_min(&minHeap);
                bricks -= smallest_ladder_eligible_jump;
            }
        } else {
            bricks -= diff;
        }

        if (bricks < 0) {
            if (ladders > 0) {
                heap_destroy(&minHeap);
            }
            return i;
        }
    }

    if (ladders > 0) {
        heap_destroy(&minHeap);
    }

    return heightsSize - 1;
}