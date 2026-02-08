#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int findRadius(int* houses, int housesSize, int* heaters, int heatersSize) {
    qsort(houses, housesSize, sizeof(int), cmp);
    qsort(heaters, heatersSize, sizeof(int), cmp);

    int radius = 0;
    int j = 0;

    for (int i = 0; i < housesSize; i++) {
        while (j < heatersSize - 1 && abs(heaters[j] - houses[i]) >= abs(heaters[j + 1] - houses[i])) {
            j++;
        }
        int dist = abs(heaters[j] - houses[i]);
        if (dist > radius) {
            radius = dist;
        }
    }

    return radius;
}