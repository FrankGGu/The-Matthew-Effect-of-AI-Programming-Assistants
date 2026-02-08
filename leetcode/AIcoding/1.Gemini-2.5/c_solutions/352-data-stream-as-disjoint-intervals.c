#include <stdlib.h> // For malloc, realloc, free
#include <string.h> // For memset (not strictly needed for this solution, but common)

static int min_val(int a, int b) { return a < b ? a : b; }
static int max_val(int a, int b) { return a > b ? a : b; }

typedef struct {
    int** intervals;
    int size;
    int capacity;
} SummaryRanges;

SummaryRanges* summaryRangesCreate() {
    SummaryRanges* obj = (SummaryRanges*)malloc(sizeof(SummaryRanges));
    obj->capacity = 10; // Initial capacity
    obj->intervals = (int**)malloc(obj->capacity * sizeof(int*));
    obj->size = 0;
    return obj;
}

void summaryRangesAddNum(SummaryRanges* obj, int val) {
    // 1. Binary search to find the first interval `it` such that `it[1] >= val - 1`.
    // This `start_search_idx` is the potential starting point for merging or insertion.
    int low = 0, high = obj->size - 1;
    int start_search_idx = obj->size; // Default to insert at end if no overlap/touch
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (obj->intervals[mid][1] >= val - 1) { 
            start_search_idx = mid;
            high = mid - 1;
        } else { 
            low = mid + 1;
        }
    }

    int new_start = val;
    int new_end = val;
    int remove_start_idx = -1; // Index of the first interval to remove
    int remove_end_idx = -1;   // Index of the last interval to remove

    // 2. Iterate from `start_search_idx` to find all overlapping/touching intervals
    for (int i = start_search_idx; i < obj->size; ++i) {
        int* curr_interval = obj->intervals[i];
        // Check for overlap or touch (val-1, val, val+1)
        // An interval [a,b] overlaps/touches val if (a <= val+1) AND (b >= val-1)
        if (curr_interval[0] <= val + 1 && curr_interval[1] >= val - 1) {
            // If val is already inside an interval, do nothing
            if (val >= curr_interval[0] && val <= curr_interval[1]) {
                return;
            }
            new_start = min_val(new_start, curr_interval[0]);
            new_end = max_val(new_end, curr_interval[1]);
            if (remove_start_idx == -1) {
                remove_start_idx = i;
            }
            remove_end_idx = i;
        } else if (curr_interval[0] > val + 1) {
            // Intervals are sorted, so no more overlaps/touches after this
            break;
        }
    }

    // 3. Process based on whether merges happened
    if (remove_start_idx != -1) { // There were overlapping/touching intervals
        int num_removed = remove_end_idx - remove_start_idx + 1;

        // Free memory for removed intervals
        for (int k = remove_start_idx; k <= remove_end_idx; ++k) {
            free(obj->intervals[k]);
        }

        // Insert the new merged interval at `remove_start_idx`
        obj->intervals[remove_start_idx] = (int*)malloc(2 * sizeof(int));
        obj->intervals[remove_start_idx][0] = new_start;
        obj->intervals[remove_start_idx][1] = new_end;

        // Shift remaining intervals to fill the gap
        // Elements from remove_end_idx + 1 onwards need to be shifted left
        // to `remove_start_idx + 1` onwards.
        for (int k = remove_end_idx + 1; k < obj->size; ++k) {
            obj->intervals[remove_start_idx + 1 + (k - (remove_end_idx + 1))] = obj->intervals[k];
        }

        obj->size -= (num_removed - 1); // Size decreases by num_removed, but increases by 1 for new interval
    } else { // No overlapping/touching intervals, insert [val, val]
        // The `start_search_idx` from step 1 already gives the correct insertion point
        // if no intervals were found to merge.
        int insert_pos = start_search_idx;

        // Reallocate if needed
        if (obj->size == obj->capacity) {
            obj->capacity *= 2;
            obj->intervals = (int**)realloc(obj->intervals, obj->capacity * sizeof(int*));
            // In a real application, check for realloc failure: if (!obj->intervals) {  return; }
        }

        // Shift elements to make space
        for (int k = obj->size; k > insert_pos; --k) {
            obj->intervals[k] = obj->intervals[k-1];
        }

        // Insert new interval
        obj->intervals[insert_pos] = (int*)malloc(2 * sizeof(int));
        obj->intervals[insert_pos][0] = val;
        obj->intervals[insert_pos][1] = val;
        obj->size++;
    }
}

int** summaryRangesGetIntervals(SummaryRanges* obj, int* returnSize) {
    *returnSize = obj->size;
    if (obj->size == 0) {
        return NULL;
    }
    int** result = (int**)malloc(obj->size * sizeof(int*));
    for (int i = 0; i < obj->size; ++i) {
        result[i] = (int*)malloc(2 * sizeof(int));
        result[i][0] = obj->intervals[i][0];
        result[i][1] = obj->intervals[i][1];
    }
    return result;
}

void summaryRangesFree(SummaryRanges* obj) {
    if (obj == NULL) return;
    for (int i = 0; i < obj->size; ++i) {
        free(obj->intervals[i]);
    }
    free(obj->intervals);
    free(obj);
}