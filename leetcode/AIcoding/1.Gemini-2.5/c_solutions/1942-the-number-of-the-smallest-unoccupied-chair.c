#include <stdlib.h> // For malloc, free, qsort
#include <stdbool.h> // For bool

typedef struct {
    int* arr;
    int capacity;
    int size;
} MinHeap;

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heap_init(MinHeap* heap, int capacity) {
    heap->arr = (int*)malloc(sizeof(int) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
}

void heap_destroy(MinHeap* heap) {
    free(heap->arr);
    heap->arr = NULL;
    heap->capacity = 0;
    heap->size = 0;
}

void heap_bubble_up(MinHeap* heap, int idx) {
    int parent_idx = (idx - 1) / 2;
    while (idx > 0 && heap->arr[parent_idx] > heap->arr[idx]) {
        swap(&heap->arr[idx], &heap->arr[parent_idx]);
        idx = parent_idx;
        parent_idx = (idx - 1) / 2;
    }
}

void heap_bubble_down(MinHeap* heap, int idx) {
    int left_child_idx = 2 * idx + 1;
    int right_child_idx = 2 * idx + 2;
    int smallest_idx = idx;

    if (left_child_idx < heap->size && heap->arr[left_child_idx] < heap->arr[smallest_idx]) {
        smallest_idx = left_child_idx;
    }
    if (right_child_idx < heap->size && heap->arr[right_child_idx] < heap->arr[smallest_idx]) {
        smallest_idx = right_child_idx;
    }

    if (smallest_idx != idx) {
        swap(&heap->arr[idx], &heap->arr[smallest_idx]);
        heap_bubble_down(heap, smallest_idx);
    }
}

void heap_push(MinHeap* heap, int val) {
    if (heap->size == heap->capacity) {
        return; 
    }
    heap->arr[heap->size] = val;
    heap->size++;
    heap_bubble_up(heap, heap->size - 1);
}

int heap_pop(MinHeap* heap) {
    if (heap->size == 0) {
        return -1; 
    }
    int val = heap->arr[0];
    heap->arr[0] = heap->arr[heap->size - 1];
    heap->size--;
    heap_bubble_down(heap, 0);
    return val;
}

typedef struct {
    int time;
    int type; // 0 for arrival, 1 for departure
    int customer_idx;
} Event;

int compareEvents(const void* a, const void* b) {
    Event* eventA = (Event*)a;
    Event* eventB = (Event*)b;

    if (eventA->time != eventB->time) {
        return eventA->time - eventB->time;
    }
    // If times are equal, departures (type 1) should come before arrivals (type 0)
    return eventB->type - eventA->type; 
}

int smallestUnoccupiedChair(int** times, int timesSize, int* timesColSize, int targetCustomer) {
    int num_customers = timesSize;
    int num_events = 2 * num_customers;

    Event* events = (Event*)malloc(sizeof(Event) * num_events);
    if (!events) return -1; 

    for (int i = 0; i < num_customers; ++i) {
        events[2 * i].time = times[i][0];
        events[2 * i].type = 0; // Arrival
        events[2 * i].customer_idx = i;

        events[2 * i + 1].time = times[i][1];
        events[2 * i + 1].type = 1; // Departure
        events[2 * i + 1].customer_idx = i;
    }

    qsort(events, num_events, sizeof(Event), compareEvents);

    MinHeap available_chairs_pq;
    heap_init(&available_chairs_pq, num_customers);

    for (int i = 0; i < num_customers; ++i) {
        heap_push(&available_chairs_pq, i);
    }

    int* customer_chair_map = (int*)malloc(sizeof(int) * num_customers);
    if (!customer_chair_map) {
        free(events);
        heap_destroy(&available_chairs_pq);
        return -1; 
    }

    for (int i = 0; i < num_events; ++i) {
        Event current_event = events[i];

        if (current_event.type == 0) { // Arrival
            int chair = heap_pop(&available_chairs_pq);
            customer_chair_map[current_event.customer_idx] = chair;
            if (current_event.customer_idx == targetCustomer) {
                free(events);
                free(customer_chair_map);
                heap_destroy(&available_chairs_pq);
                return chair;
            }
        } else { // Departure
            int chair_to_free = customer_chair_map[current_event.customer_idx];
            heap_push(&available_chairs_pq, chair_to_free);
        }
    }

    free(events);
    free(customer_chair_map);
    heap_destroy(&available_chairs_pq);
    return -1; 
}