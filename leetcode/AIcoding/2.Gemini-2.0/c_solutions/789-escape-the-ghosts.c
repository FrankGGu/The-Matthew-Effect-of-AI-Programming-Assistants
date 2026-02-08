#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int abs(int x) {
    return x > 0 ? x : -x;
}

bool escapeGhosts(int** ghosts, int ghostsSize, int* ghostsColSize, int* target, int targetSize) {
    int player_dist = abs(target[0]) + abs(target[1]);
    for (int i = 0; i < ghostsSize; i++) {
        int ghost_dist = abs(ghosts[i][0] - target[0]) + abs(ghosts[i][1] - target[1]);
        if (ghost_dist <= player_dist) {
            return false;
        }
    }
    return true;
}