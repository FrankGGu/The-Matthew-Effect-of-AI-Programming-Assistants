#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memmove

#define INITIAL_CAPACITY 16
#define RESIZE_FACTOR 2

#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define MAX(a, b) ((a) > (b) ? (a) : (b))

typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    Interval *intervals; // Dynamic array of intervals
    int capacity;        // Current capacity of the array
    int size;            // Current number of intervals
} RangeModule;

static void ensureCapacity(RangeModule* obj, int required_capacity) {
    if (obj->capacity < required_capacity) {
        int new_capacity = obj->capacity;
        while (new_capacity < required_capacity) {
            new_capacity *= RESIZE_FACTOR;
        }
        obj->intervals = (Interval*)realloc(obj->intervals, new_capacity * sizeof(Interval));
        obj->capacity = new_capacity;
    }
}

static int find_first_overlap_or_after(RangeModule* obj, int target_start) {
    int low = 0, high = obj->size - 1;
    int ans = obj->size; // Default to no overlap, or all intervals before
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (obj->intervals[mid].end >= target_start) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

static int find_first_ge(RangeModule* obj, int target_start) {
    int low = 0, high = obj->size - 1;
    int ans = obj->size;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (obj->intervals[mid].start >= target_start) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

RangeModule* rangeModuleCreate() {
    RangeModule* obj = (RangeModule*)malloc(sizeof(RangeModule));
    obj->intervals = (Interval*)malloc(INITIAL_CAPACITY * sizeof(Interval));
    obj->capacity = INITIAL_CAPACITY;
    obj->size = 0;
    return obj;
}

void rangeModuleAddRange(RangeModule* obj, int left, int right) {
    if (left >= right) return; // Invalid range

    // Find the first interval that potentially overlaps with [left, right)
    // Its end is >= left
    int start_idx = find_first_overlap_or_after(obj, left);

    // Find the first interval whose start is >= right.
    // All intervals before this index (from start_idx) might be merged.
    int end_idx = find_first_ge(obj, right);

    // Initialize new merged range with the input range
    int new_left = left;
    int new_right = right;

    // Expand the new merged range by incorporating all overlapping intervals
    for (int i = start_idx; i < end_idx; ++i) {
        new_left = MIN(new_left, obj->intervals[i].start);
        new_right = MAX(new_right, obj->intervals[i].end);
    }

    // Calculate the number of intervals to be removed and the new total size
    int num_removed = end_idx - start_idx;
    int new_size = obj->size - num_removed + 1;

    // Ensure capacity for the new size
    ensureCapacity(obj, new_size);

    // Shift intervals to make space for the new merged interval
    if (num_removed > 0) {
        // If intervals were removed, shift elements from end_idx to start_idx + 1
        memmove(&obj->intervals[start_idx + 1], &obj->intervals[end_idx],
                (obj->size - end_idx) * sizeof(Interval));
    } else { // No intervals were removed, pure insertion
        // Shift elements from start_idx one position to the right
        memmove(&obj->intervals[start_idx + 1], &obj->intervals[start_idx],
                (obj->size - start_idx) * sizeof(Interval));
    }

    // Insert the new merged interval at start_idx
    obj->intervals[start_idx].start = new_left;
    obj->intervals[start_idx].end = new_right;
    obj->size = new_size;
}

bool rangeModuleQueryRange(RangeModule* obj, int left, int right) {
    if (left >= right) return true; // An empty or invalid range is considered covered

    // Find the first interval whose end is >= left
    int idx = find_first_overlap_or_after(obj, left);

    // Check if this interval exists and completely covers [left, right)
    if (idx < obj->size && obj->intervals[idx].start <= left && obj->intervals[idx].end >= right) {
        return true;
    }
    return false;
}

void rangeModuleRemoveRange(RangeModule* obj, int left, int right) {
    if (left >= right) return; // Invalid range

    // A temporary list to construct the new set of intervals
    // Start with current capacity, will realloc if needed
    Interval* temp_intervals = (Interval*)malloc(obj->capacity * sizeof(Interval));
    int temp_size = 0;

    // Find the index of the first interval whose end is >= left.
    // This marks the beginning of intervals that might be affected.
    int start_idx_to_process = find_first_overlap_or_after(obj, left);

    // 1. Copy intervals that are completely before [left, right)
    for (int i = 0; i < start_idx_to_process; ++i) {
        if (temp_size >= obj->capacity) { // Resize temp_intervals if needed
            obj->capacity *= RESIZE_FACTOR;
            temp_intervals = (Interval*)realloc(temp_intervals, obj->capacity * sizeof(Interval));
        }
        temp_intervals[temp_size++] = obj->intervals[i];
    }

    // 2. Process intervals that overlap with [left, right) or start before 'right'
    for (int i = start_idx_to_process; i < obj->size; ++i) {
        Interval current = obj->intervals[i];

        // If the current interval starts at or after 'right', it's completely after the removal range.
        // Copy it and all subsequent intervals, then stop processing.
        if (current.start >= right) {
            for (int j = i; j < obj->size; ++j) {
                 if (temp_size >= obj->capacity) {
                    obj->capacity *= RESIZE_FACTOR;
                    temp_intervals = (Interval*)realloc(temp_intervals, obj->capacity * sizeof(Interval));
                }
                temp_intervals[temp_size++] = obj->intervals[j];
            }
            break; // All remaining intervals are copied, so we can stop.
        }

        // The current interval [s, e] overlaps with [left, right).
        // We need to add parts of 'current' that are *outside* [left, right).

        // Add the part of 'current' that is before 'left'
        if (current.start < left) {
            if (temp_size >= obj->capacity) {
                obj->capacity *= RESIZE_FACTOR;
                temp_intervals = (Interval*)realloc(temp_intervals, obj->capacity * sizeof(Interval));
            }
            temp_intervals[temp_size++] = (Interval){current.start, left};
        }

        // Add the part of 'current' that is after 'right'
        if (current.end > right) {
            if (temp_size >= obj->capacity) {
                obj->capacity *= RESIZE_FACTOR;
                temp_intervals = (Interval*)realloc(temp_intervals, obj->capacity * sizeof(Interval));
            }
            temp_intervals[temp_size++] = (Interval){right, current.end};
        }
    }

    // Free the old intervals array and replace it with the new one
    free(obj->intervals);
    obj->intervals = temp_intervals;
    obj->size = temp_size;

    // Adjust the capacity of the main intervals array
    if (obj->size == 0) {
        obj->capacity = INITIAL_CAPACITY;
        obj->intervals = (Interval*)realloc(obj->intervals, obj->capacity * sizeof(Interval));
    } else if (obj->capacity > obj->size * RESIZE_FACTOR) {
        // Shrink capacity if it's much larger than needed
        obj->capacity = obj->size * RESIZE_FACTOR;
        obj->intervals = (Interval*)realloc(obj->intervals, obj->capacity * sizeof(Interval));
    } else if (obj->capacity < obj->size) { 
        // This case should ideally not happen if resizing was handled correctly within the loop,
        // but as a safeguard, ensure capacity is at least size.
        obj->capacity = obj->size;
        obj->intervals = (Interval*)realloc(obj->intervals, obj->capacity * sizeof(Interval));
    }
}

void rangeModuleFree(RangeModule* obj) {
    if (obj) {
        free(obj->intervals); // Free the dynamic array of intervals
        free(obj);            // Free the RangeModule struct itself
    }
}