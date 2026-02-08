#include <stdlib.h> // For malloc, free, qsort, realloc

typedef struct {
    int coord;
    int type; // +1 for start, -1 for end
    int color;
} Event;

int compareEvents(const void *a, const void *b) {
    Event *eventA = (Event *)a;
    Event *eventB = (Event *)b;

    if (eventA->coord != eventB->coord) {
        return eventA->coord - eventB->coord;
    }
    // If coordinates are equal, process start events (+1) before end events (-1)
    // This order ensures that for adjacent segments [A,X] and [X,B],
    // the color sum for [A,X] is correctly recorded before X is processed.
    return eventA->type - eventB->type;
}

long long** describeThePainting(int** paintings, int paintingsSize, int* paintingsColSize, int* returnSize, int** returnColumnSizes) {
    int numEvents = 2 * paintingsSize;
    Event* events = (Event*)malloc(numEvents * sizeof(Event));

    for (int i = 0; i < paintingsSize; ++i) {
        events[2 * i].coord = paintings[i][0];
        events[2 * i].type = 1; // Start event
        events[2 * i].color = paintings[i][2];

        events[2 * i + 1].coord = paintings[i][1];
        events[2 * i + 1].type = -1; // End event
        events[2 * i + 1].color = paintings[i][2];
    }

    qsort(events, numEvents, sizeof(Event), compareEvents);

    // Max possible segments is numEvents (worst case, each event starts a new segment)
    long long** result = (long long**)malloc(numEvents * sizeof(long long*));
    *returnColumnSizes = (int*)malloc(numEvents * sizeof(int));

    *returnSize = 0;
    long long current_color_sum = 0;
    int last_coord = -1;

    for (int i = 0; i < numEvents; ) {
        int current_coord = events[i].coord;

        if (last_coord != -1 && current_coord > last_coord) {
            if (current_color_sum > 0) {
                result[*returnSize] = (long long*)malloc(3 * sizeof(long long));
                result[*returnSize][0] = last_coord;
                result[*returnSize][1] = current_coord;
                result[*returnSize][2] = current_color_sum;
                (*returnColumnSizes)[*returnSize] = 3;
                (*returnSize)++;
            }
        }

        int j = i;
        while (j < numEvents && events[j].coord == current_coord) {
            current_color_sum += (long long)events[j].type * events[j].color;
            j++;
        }

        last_coord = current_coord;
        i = j;
    }

    // Resize result arrays to actual size
    result = (long long**)realloc(result, (*returnSize) * sizeof(long long*));
    *returnColumnSizes = (int*)realloc(*returnColumnSizes, (*returnSize) * sizeof(int));

    free(events);

    return result;
}