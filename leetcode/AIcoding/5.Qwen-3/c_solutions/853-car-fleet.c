#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Pair;

int compare(const void* a, const void* b) {
    Pair* pa = (Pair*)a;
    Pair* pb = (Pair*)b;
    return pa->x - pb->x;
}

int carFleet(int target, int* position, int positionSize, int* speed, int speedSize) {
    Pair* pairs = (Pair*)malloc(positionSize * sizeof(Pair));
    for (int i = 0; i < positionSize; i++) {
        pairs[i].x = position[i];
        pairs[i].y = speed[i];
    }
    qsort(pairs, positionSize, sizeof(Pair), compare);

    int count = 0;
    double time = 0.0;

    for (int i = positionSize - 1; i >= 0; i--) {
        double t = (double)(target - pairs[i].x) / pairs[i].y;
        if (t > time) {
            count++;
            time = t;
        }
    }

    free(pairs);
    return count;
}