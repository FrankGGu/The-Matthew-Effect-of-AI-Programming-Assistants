#include <stdio.h>
#include <stdlib.h>

int escapeGhosts(int* ghosts, int ghostsSize, int* target, int targetSize) {
    int playerDistance = abs(target[0]) + abs(target[1]);
    for (int i = 0; i < ghostsSize; i++) {
        int ghostDistance = abs(ghosts[i * 2] - target[0]) + abs(ghosts[i * 2 + 1] - target[1]);
        if (ghostDistance <= playerDistance) {
            return 0;
        }
    }
    return 1;
}