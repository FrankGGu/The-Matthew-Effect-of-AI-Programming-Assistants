#include <stdbool.h>

bool canMoveRobots(int* positions, int positionsSize, int* moves, int movesSize) {
    int left = 0, right = 0;

    for (int i = 0; i < positionsSize; i++) {
        if (positions[i] < 0) left++;
        else if (positions[i] > 0) right++;
    }

    for (int i = 0; i < movesSize; i++) {
        if (moves[i] < 0) left++;
        else if (moves[i] > 0) right++;
    }

    return left == right;
}