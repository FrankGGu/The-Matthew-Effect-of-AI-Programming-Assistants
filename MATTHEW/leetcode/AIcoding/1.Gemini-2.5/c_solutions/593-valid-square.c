#include <stdbool.h>
#include <stdlib.h>

int distSq(int* p1, int* p2) {
    int dx = p1[0] - p2[0];
    int dy = p1[1] - p2[1];
    return dx * dx + dy * dy;
}

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

bool validSquare(int* p1, int* p2, int* p3, int* p4, int p1Size, int p2Size, int p3Size, int p4Size) {
    int distances[6];
    distances[0] = distSq(p1, p2);
    distances[1] = distSq(p1, p3);
    distances[2] = distSq(p1, p4);
    distances[3] = distSq(p2, p3);
    distances[4] = distSq(p2, p4);
    distances[5] = distSq(p3, p4);

    qsort(distances, 6, sizeof(int), compare);

    if (distances[0] == 0) {
        return false;
    }

    if (distances[0] != distances[1] ||
        distances[1] != distances[2] ||
        distances[2] != distances[3]) {
        return false;
    }

    if (distances[4] != distances[5]) {
        return false;
    }

    if (distances[4] != 2 * distances[0]) {
        return false;
    }

    return true;
}