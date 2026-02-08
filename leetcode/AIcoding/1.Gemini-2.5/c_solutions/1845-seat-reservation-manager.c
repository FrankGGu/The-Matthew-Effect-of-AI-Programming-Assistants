#include <stdlib.h> // Required for malloc and free

static void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

static void heap_bubble_up(int* heap, int index) {
    while (index > 0 && heap[(index - 1) / 2] > heap[index]) {
        swap(&heap[index], &heap[(index - 1) / 2]);
        index = (index - 1) / 2;
    }
}

static void heap_bubble_down(int* heap, int heap_size, int index) {
    int smallest = index;
    int left_child = 2 * index + 1;
    int right_child = 2 * index + 2;

    if (left_child < heap_size && heap[left_child] < heap[smallest]) {
        smallest = left_child;
    }

    if (right_child < heap_size && heap[right_child] < heap[smallest]) {
        smallest = right_child;
    }

    if (smallest != index) {
        swap(&heap[index], &heap[smallest]);
        heap_bubble_down(heap, heap_size, smallest);
    }
}

typedef struct {
    int* heap_array;
    int heap_size;
    // int heap_capacity; // Not strictly needed as capacity is fixed 'n'
} SeatManager;

SeatManager* seatManagerCreate(int n) {
    SeatManager* obj = (SeatManager*)malloc(sizeof(SeatManager));
    obj->heap_array = (int*)malloc(sizeof(int) * n);
    obj->heap_size = n; // Initially all seats from 1 to n are available

    // Populate the heap with seats 1 to n.
    // Since they are inserted in increasing order, the array [1, 2, ..., n]
    // is already a valid min-heap. No need for a separate heapify step.
    for (int i = 0; i < n; ++i) {
        obj->heap_array[i] = i + 1;
    }
    return obj;
}

int seatManagerReserve(SeatManager* obj) {
    // The smallest unreserved seat is always at the root of the min-heap.
    int reserved_seat = obj->heap_array[0];

    // Replace the root with the last element in the heap.
    obj->heap_array[0] = obj->heap_array[obj->heap_size - 1];
    obj->heap_size--; // Decrease heap size

    // Restore the min-heap property by bubbling down the new root.
    heap_bubble_down(obj->heap_array, obj->heap_size, 0);

    return reserved_seat;
}

void seatManagerUnreserve(SeatManager* obj, int seatNumber) {
    // Add the unreserved seat to the end of the heap.
    obj->heap_array[obj->heap_size] = seatNumber;
    obj->heap_size++; // Increase heap size

    // Restore the min-heap property by bubbling up the newly added element.
    heap_bubble_up(obj->heap_array, obj->heap_size - 1);
}

void seatManagerFree(SeatManager* obj) {
    free(obj->heap_array);
    free(obj);
}