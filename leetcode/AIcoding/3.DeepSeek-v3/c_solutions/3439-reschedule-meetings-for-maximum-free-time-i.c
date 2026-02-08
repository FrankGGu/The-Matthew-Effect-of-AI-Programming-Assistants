#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return (*(int**)a)[0] - (*(int**)b)[0];
}

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maxFreeTime(int eventCount, int** events, int k) {
    qsort(events, eventCount, sizeof(int*), cmp);

    int maxGap = 0;
    for (int i = 1; i < eventCount; i++) {
        maxGap = max(maxGap, events[i][0] - events[i-1][1]);
    }

    if (k == 0) return maxGap;

    int* starts = (int*)malloc(eventCount * sizeof(int));
    int* ends = (int*)malloc(eventCount * sizeof(int));

    for (int i = 0; i < eventCount; i++) {
        starts[i] = events[i][0];
        ends[i] = events[i][1];
    }

    int result = maxGap;

    for (int i = 0; i < eventCount; i++) {
        for (int j = i + 1; j < eventCount; j++) {
            int temp = ends[i];
            ends[i] = starts[j];
            starts[j] = temp;

            int currentMax = 0;
            for (int idx = 1; idx < eventCount; idx++) {
                currentMax = max(currentMax, starts[idx] - ends[idx-1]);
            }
            result = max(result, currentMax);

            ends[i] = events[i][1];
            starts[j] = events[j][0];
        }
    }

    free(starts);
    free(ends);

    return result;
}