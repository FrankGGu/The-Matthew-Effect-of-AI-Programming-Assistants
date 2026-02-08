#include <stdlib.h>
#include <stdbool.h>

bool isReachableAtTime(int sx, int sy, int tx, int ty, int t) {
    int dx = abs(sx - tx);
    int dy = abs(sy - ty);

    int min_steps = (dx > dy) ? dx : dy;

    if (min_steps == 0) {
        return t != 1;
    } else {
        return t >= min_steps;
    }
}