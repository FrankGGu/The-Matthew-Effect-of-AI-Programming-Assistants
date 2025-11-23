#include <stdlib.h>

int distanceSquared(int* p1, int* p2) {
    return (p1[0] - p2[0]) * (p1[0] - p2[0]) + (p1[1] - p2[1]) * (p1[1] - p2[1]);
}

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

bool validSquare(int* p1, int p1Size, int* p2, int p2Size, int* p3, int p3Size, int* p4, int p4Size) {
    int points[4][2] = {{p1[0], p1[1]}, {p2[0], p2[1]}, {p3[0], p3[1]}, {p4[0], p4[1]}};

    int distances[6];
    int index = 0;
    for (int i = 0; i < 4; i++) {
        for (int j = i + 1; j < 4; j++) {
            distances[index++] = distanceSquared(points[i], points[j]);
        }
    }

    qsort(distances, 6, sizeof(int), compare);

    return distances[0] > 0 && 
           distances[0] == distances[1] && 
           distances[1] == distances[2] && 
           distances[2] == distances[3] && 
           distances[4] == distances[5] && 
           distances[0] * 2 == distances[4];
}