#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isReachableAtTime(int sx, int sy, int fx, int fy, int t) {
    int dx = abs(sx - fx);
    int dy = abs(sy - fy);
    int max_dist = (dx > dy) ? dx : dy;

    if (max_dist == 0) {
        return (t != 1);
    }

    return (t >= max_dist);
}