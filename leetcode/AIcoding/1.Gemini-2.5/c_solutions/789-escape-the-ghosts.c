#include <stdlib.h> // Required for abs()
#include <stdbool.h> // Required for bool type

bool escapeGhosts(int** ghosts, int ghostsSize, int* ghostsColSize, int* target, int targetSize) {
    int player_time = abs(target[0]) + abs(target[1]);

    for (int i = 0; i < ghostsSize; i++) {
        int ghost_x = ghosts[i][0];
        int ghost_y = ghosts[i][1];
        int ghost_time = abs(target[0] - ghost_x) + abs(target[1] - ghost_y);

        if (player_time >= ghost_time) {
            return false;
        }
    }

    return true;
}