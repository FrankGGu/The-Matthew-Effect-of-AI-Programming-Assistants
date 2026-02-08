#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int distSq(int* p1, int* p2) {
    return (p1[0] - p2[0]) * (p1[0] - p2[0]) + (p1[1] - p2[1]) * (p1[1] - p2[1]);
}

bool validSquare(int* p1, int p1Size, int* p2, int p2Size, int* p3, int p3Size, int* p4, int p4Size) {
    int distances[6];
    distances[0] = distSq(p1, p2);
    distances[1] = distSq(p1, p3);
    distances[2] = distSq(p1, p4);
    distances[3] = distSq(p2, p3);
    distances[4] = distSq(p2, p4);
    distances[5] = distSq(p3, p4);

    int side = -1;
    int diagonal = -1;
    int sideCount = 0;
    int diagonalCount = 0;

    for (int i = 0; i < 6; i++) {
        if (distances[i] == 0) return false;
        if (side == -1) {
            side = distances[i];
            sideCount++;
        } else if (distances[i] == side) {
            sideCount++;
        } else if (diagonal == -1) {
            diagonal = distances[i];
            diagonalCount++;
        } else if (distances[i] == diagonal) {
            diagonalCount++;
        } else {
            return false;
        }
    }

    return (sideCount == 4 && diagonalCount == 2 && diagonal == 2 * side);
}