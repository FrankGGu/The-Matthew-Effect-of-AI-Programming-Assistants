#include <stdbool.h>
#include <math.h>

bool escapeGhosts(int** ghosts, int ghostsSize, int* ghostsColSize, int* target, int targetSize) {
    int playerDistance = abs(target[0]) + abs(target[1]);
    for (int i = 0; i < ghostsSize; i++) {
        int ghostDistance = abs(ghosts[i][0] - target[0]) + abs(ghosts[i][1] - target[1]);
        if (ghostDistance <= playerDistance) {
            return false;
        }
    }
    return true;
}