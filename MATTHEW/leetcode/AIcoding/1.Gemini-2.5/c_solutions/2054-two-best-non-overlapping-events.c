#include <stdlib.h>

static inline int int_max(int a, int b) {
    return a > b ? a : b;
}

int compareEvents(const void *a, const void *b) {
    const int *eventA = *(const int **)a;
    const int *eventB = *(const int **)b;

    if (eventA[0] != eventB[0]) {
        return eventA[0] - eventB[0];
    }
    return eventA[1] - eventB[1];
}

int findNextEventIndex(int** events, int n, int startIndex, int target_endTime) {
    int low = startIndex;
    int high = n - 1;
    int result_idx = n;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (events[mid][0] > target_endTime) {
            result_idx = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return result_idx;
}

int maxTwoEvents(int** events, int eventsSize, int* eventsColSize) {
    if (eventsSize == 0) {
        return 0;
    }

    qsort(events, eventsSize, sizeof(int*), compareEvents);

    int* max_val_from_right = (int*)malloc(eventsSize * sizeof(int));

    max_val_from_right[eventsSize - 1] = events[eventsSize - 1][2];
    for (int i = eventsSize - 2; i >= 0; --i) {
        max_val_from_right[i] = int_max(events[i][2], max_val_from_right[i + 1]);
    }

    int max_total_value = 0;

    for (int i = 0; i < eventsSize; ++i) {
        max_total_value = int_max(max_total_value, events[i][2]);

        int next_event_idx = findNextEventIndex(events, eventsSize, i + 1, events[i][1]);

        if (next_event_idx < eventsSize) {
            max_total_value = int_max(max_total_value, events[i][2] + max_val_from_right[next_event_idx]);
        }
    }

    free(max_val_from_right);
    return max_total_value;
}