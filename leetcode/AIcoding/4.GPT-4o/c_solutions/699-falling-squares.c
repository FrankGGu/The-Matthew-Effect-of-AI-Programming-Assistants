#include <stdlib.h>

struct Event {
    int start;
    int end;
    int height;
};

int cmp(const void *a, const void *b) {
    return ((struct Event *)a)->start - ((struct Event *)b)->start;
}

int fallingSquares(int** positions, int positionsSize, int* positionsColSize, int* returnSize) {
    struct Event events[positionsSize * 2];
    int heights[positionsSize];

    for (int i = 0; i < positionsSize; i++) {
        events[i * 2].start = positions[i][0];
        events[i * 2].end = positions[i][0] + positions[i][1];
        events[i * 2].height = positions[i][1];
        heights[i] = 0;
    }

    int totalEvents = positionsSize * 2;
    qsort(events, totalEvents, sizeof(struct Event), cmp);

    int *result = (int *)malloc(sizeof(int) * positionsSize);
    int maxHeight = 0;
    int currentHeight = 0;

    for (int i = 0; i < totalEvents; i++) {
        if (i % 2 == 0) {
            currentHeight += events[i].height;
        } else {
            currentHeight -= events[i - 1].height;
        }
        if (currentHeight > maxHeight) {
            maxHeight = currentHeight;
        }
        result[i / 2] = maxHeight;
    }

    *returnSize = positionsSize;
    return result;
}