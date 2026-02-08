#include <stdbool.h> // For bool

typedef struct {
    int rot_day;
    int count;
} HeapNode;

#define MAX_HEAP_CAPACITY 20005

HeapNode min_heap[MAX_HEAP_CAPACITY];
int heap_size;

void swap(HeapNode *a, HeapNode *b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void heap_init() {
    heap_size = 0;
}

void heap_sift_up(int idx) {
    while (idx > 0 && min_heap[idx].rot_day < min_heap[(idx - 1) / 2].rot_day) {
        swap(&min_heap[idx], &min_heap[(idx - 1) / 2]);
        idx = (idx - 1) / 2;
    }
}

void heap_sift_down(int idx) {
    int left_child = 2 * idx + 1;
    int right_child = 2 * idx + 2;
    int smallest = idx;

    if (left_child < heap_size && min_heap[left_child].rot_day < min_heap[smallest].rot_day) {
        smallest = left_child;
    }
    if (right_child < heap_size && min_heap[right_child].rot_day < min_heap[smallest].rot_day) {
        smallest = right_child;
    }

    if (smallest != idx) {
        swap(&min_heap[idx], &min_heap[smallest]);
        heap_sift_down(smallest);
    }
}

void heap_push(int rot_day, int count) {
    if (count <= 0) return;

    min_heap[heap_size].rot_day = rot_day;
    min_heap[heap_size].count = count;
    heap_sift_up(heap_size);
    heap_size++;
}

HeapNode heap_peek() {
    return min_heap[0];
}

void heap_pop() {
    heap_size--;
    min_heap[0] = min_heap[heap_size];
    heap_sift_down(0);
}

bool heap_is_empty() {
    return heap_size == 0;
}

int maxApples(int* apples, int applesSize, int* days, int daysSize) {
    heap_init();

    int eaten_apples = 0;

    int max_possible_day_to_consider = applesSize + 20000; 

    for (int i = 0; i < max_possible_day_to_consider; ++i) {
        if (i < applesSize) {
            if (apples[i] > 0 && days[i] > 0) { 
                heap_push(i + days[i], apples[i]);
            }
        }

        while (!heap_is_empty() && heap_peek().rot_day <= i) {
            heap_pop();
        }

        if (!heap_is_empty()) {
            eaten_apples++;
            min_heap[0].count--; 

            if (min_heap[0].count == 0) {
                heap_pop();
            }
        }

        if (i >= applesSize && heap_is_empty()) {
            break;
        }
    }

    return eaten_apples;
}