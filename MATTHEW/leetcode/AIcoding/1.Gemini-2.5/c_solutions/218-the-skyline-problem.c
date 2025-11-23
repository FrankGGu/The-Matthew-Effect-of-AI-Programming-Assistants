#include <stdlib.h>
#include <string.h> // For memmove

typedef struct {
    int x;
    int height; // Negative for start event, positive for end event
} Event;

int compareEvents(const void* a, const void* b) {
    Event* event1 = (Event*)a;
    Event* event2 = (Event*)b;

    if (event1->x != event2->x) {
        return event1->x - event2->x;
    }
    // Tie-breaking rules for same x-coordinate:
    // 1. Start events (-height) come before end events (height).
    // 2. For start events, higher buildings come first (larger -height means smaller absolute height, so -H1 < -H2 if H1 > H2).
    // 3. For end events, lower buildings come first (smaller height means smaller absolute height).
    // The expression event1->height - event2->height naturally handles all these cases:
    // - If both are starts: -H1 - (-H2) = H2 - H1. If H1=20, H2=10, result is -10 (event1 before event2). Correct (higher building first).
    // - If both are ends: H1 - H2. If H1=10, H2=20, result is -10 (event1 before event2). Correct (lower building first).
    // - If event1 is start (-H1) and event2 is end (H2): -H1 - H2. Always negative. Event1 comes before Event2. Correct.
    return event1->height - event2->height;
}

typedef struct {
    int height;
    int count;
} HeightCount;

HeightCount* active_heights_map = NULL;
int active_heights_size = 0;
int active_heights_capacity = 0;

void init_active_heights_map(int initial_capacity) {
    active_heights_capacity = initial_capacity;
    active_heights_map = (HeightCount*)malloc(sizeof(HeightCount) * active_heights_capacity);
    active_heights_size = 0;
}

void resize_active_heights_map() {
    if (active_heights_size == active_heights_capacity) {
        active_heights_capacity = active_heights_capacity == 0 ? 1 : active_heights_capacity * 2;
        active_heights_map = (HeightCount*)realloc(active_heights_map, sizeof(HeightCount) * active_heights_capacity);
    }
}

int find_height_idx(int height) {
    int low = 0, high = active_heights_size - 1;
    int mid;
    while (low <= high) {
        mid = low + (high - low) / 2;
        if (active_heights_map[mid].height == height) {
            return mid; // Found
        } else if (active_heights_map[mid].height < height) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return -(low + 1); // Not found, return insertion point (negative)
}

void insert_height(int height) {
    int idx = find_height_idx(height);
    if (idx >= 0) {
        active_heights_map[idx].count++;
    } else {
        int pos = -(idx + 1);
        resize_active_heights_map();
        if (pos < active_heights_size) {
            memmove(&active_heights_map[pos + 1], &active_heights_map[pos], (active_heights_size - pos) * sizeof(HeightCount));
        }
        active_heights_map[pos].height = height;
        active_heights_map[pos].count = 1;
        active_heights_size++;
    }
}

void remove_height(int height) {
    int idx = find_height_idx(height);
    if (idx >= 0) {
        active_heights_map[idx].count--;
        if (active_heights_map[idx].count == 0) {
            if (idx < active_heights_size - 1) {
                memmove(&active_heights_map[idx], &active_heights_map[idx + 1], (active_heights_size - 1 - idx) * sizeof(HeightCount));
            }
            active_heights_size--;
        }
    }
}

int get_max_height() {
    if (active_heights_size == 0) {
        return 0;
    }
    return active_heights_map[active_heights_size - 1].height;
}

void destroy_active_heights_map() {
    free(active_heights_map);
    active_heights_map = NULL;
    active_heights_size = 0;
    active_heights_capacity = 0;
}

int** getSkyline(int** buildings, int buildingsRowSize, int* buildingsColSize, int* returnSize) {
    // Create events from buildings
    int num_events = buildingsRowSize * 2;
    Event* events = (Event*)malloc(sizeof(Event) * num_events);
    for (int i = 0; i < buildingsRowSize; i++) {
        events[2 * i].x = buildings[i][0];
        events[2 * i].height = -buildings[i][2]; // Start event, negative height
        events[2 * i + 1].x = buildings[i][1];
        events[2 * i + 1].height = buildings[i][2]; // End event, positive height
    }

    // Sort events
    qsort(events, num_events, sizeof(Event), compareEvents);

    // Initialize the multiset for active heights
    init_active_heights_map(buildingsRowSize); // Max distinct heights can be buildingsRowSize

    // Prepare result list
    int** result = (int**)malloc(sizeof(int*) * (num_events + 1)); // Max possible key points
    int result_idx = 0;
    int result_capacity = num_events + 1;

    int prev_max_height = 0;

    // Sweep line algorithm
    for (int i = 0; i < num_events; i++) {
        Event current_event = events[i];

        if (current_event.height < 0) { // Start event
            insert_height(-current_event.height);
        } else { // End event
            remove_height(current_event.height);
        }

        int current_max_height = get_max_height();

        if (current_max_height != prev_max_height) {
            // Add to result if a critical point is found
            if (result_idx == result_capacity) {
                result_capacity *= 2;
                result = (int**)realloc(result, sizeof(int*) * result_capacity);
            }
            result[result_idx] = (int*)malloc(sizeof(int) * 2);
            result[result_idx][0] = current_event.x;
            result[result_idx][1] = current_max_height;
            result_idx++;
            prev_max_height = current_max_height;
        }
    }

    // Clean up allocated memory
    destroy_active_heights_map();
    free(events);

    *returnSize = result_idx;
    return result;
}