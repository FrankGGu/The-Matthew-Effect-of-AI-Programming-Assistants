#include <stdlib.h> // For malloc, free, qsort

static int* min_heap_array;
static int min_heap_size;

void heap_init(int max_capacity) {
    min_heap_array = (int*)malloc(sizeof(int) * (max_capacity + 1));
    min_heap_size = 0;
}

void heap_destroy() {
    free(min_heap_array);
    min_heap_array = NULL;
    min_heap_size = 0;
}

void heap_push(int val) {
    min_heap_size++;
    min_heap_array[min_heap_size] = val;
    int current = min_heap_size;
    // Bubble up
    while (current > 1 && min_heap_array[current] < min_heap_array[current / 2]) {
        int temp = min_heap_array[current];
        min_heap_array[current] = min_heap_array[current / 2];
        min_heap_array[current / 2] = temp;
        current /= 2;
    }
}

int heap_pop() {
    // Caller should ensure heap is not empty
    int root = min_heap_array[1];
    min_heap_array[1] = min_heap_array[min_heap_size];
    min_heap_size--;
    int current = 1;
    // Bubble down
    while (1) {
        int left_child = 2 * current;
        int right_child = 2 * current + 1;
        int smallest = current;

        if (left_child <= min_heap_size && min_heap_array[left_child] < min_heap_array[smallest]) {
            smallest = left_child;
        }
        if (right_child <= min_heap_size && min_heap_array[right_child] < min_heap_array[smallest]) {
            smallest = right_child;
        }

        if (smallest != current) {
            int temp = min_heap_array[current];
            min_heap_array[current] = min_heap_array[smallest];
            min_heap_array[smallest] = temp;
            current = smallest;
        } else {
            break;
        }
    }
    return root;
}

int heap_peek() {
    // Caller should ensure heap is not empty
    return min_heap_array[1];
}

int heap_isEmpty() {
    return min_heap_size == 0;
}

int compareEvents(const void* a, const void* b) {
    const int* eventA = *(const int**)a;
    const int* eventB = *(const int**)b;

    if (eventA[0] != eventB[0]) {
        return eventA[0] - eventB[0];
    }
    return eventA[1] - eventB[1];
}

int maxEvents(int** events, int eventsSize, int* eventsColSize) {
    if (eventsSize == 0) {
        return 0;
    }

    // 1. Sort events by their start day
    qsort(events, eventsSize, sizeof(int*), compareEvents);

    // 2. Initialize the min-heap to store end days of available events
    heap_init(eventsSize);

    int attended_events = 0;
    int event_idx = 0; // Pointer to the next event to consider from the sorted list

    // Determine the maximum possible day to iterate up to
    // This is the maximum end day among all events
    int max_day = 0;
    for (int i = 0; i < eventsSize; ++i) {
        if (events[i][1] > max_day) {
            max_day = events[i][1];
        }
    }

    // 3. Iterate through each day from 1 to max_day
    for (int d = 1; d <= max_day; ++d) {
        // Add all events that start on day 'd' to the heap
        // The heap stores their end days
        while (event_idx < eventsSize && events[event_idx][0] == d) {
            heap_push(events[event_idx][1]);
            event_idx++;
        }

        // Remove events from the heap that have already ended before day 'd'
        while (!heap_isEmpty() && heap_peek() < d) {
            heap_pop();
        }

        // If there are any events available for day 'd', attend the one
        // that ends earliest (greedy choice)
        if (!heap_isEmpty()) {
            heap_pop(); // Attend this event
            attended_events++;
        }

        // Optimization: If all events have been processed (added to heap)
        // and the heap is empty, no more events can be attended.
        if (event_idx == eventsSize && heap_isEmpty()) {
            break;
        }
    }

    // Clean up allocated heap memory
    heap_destroy();

    return attended_events;
}