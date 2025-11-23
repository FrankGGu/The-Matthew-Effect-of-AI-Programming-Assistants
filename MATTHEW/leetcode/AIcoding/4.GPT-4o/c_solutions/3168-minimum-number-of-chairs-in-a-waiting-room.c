#include <stdlib.h>

int minNumberOfChairs(int** time, int timeSize, int* timeColSize) {
    int events[2000][2] = {0};
    int idx = 0;

    for (int i = 0; i < timeSize; i++) {
        events[idx][0] = time[i][0]; // start time
        events[idx][1] = 1; // enter
        idx++;
        events[idx][0] = time[i][1]; // end time
        events[idx][1] = -1; // leave
        idx++;
    }

    qsort(events, idx, sizeof(events[0]), [](const void *a, const void *b) {
        return ((int(*)[2])a)[0][0] - ((int(*)[2])b)[0][0];
    });

    int maxChairs = 0, currentChairs = 0;

    for (int i = 0; i < idx; i++) {
        currentChairs += events[i][1];
        if (currentChairs > maxChairs) {
            maxChairs = currentChairs;
        }
    }

    return maxChairs;
}