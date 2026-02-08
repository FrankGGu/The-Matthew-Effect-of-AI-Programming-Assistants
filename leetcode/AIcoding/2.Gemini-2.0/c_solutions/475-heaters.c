#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findRadius(int* houses, int housesSize, int* heaters, int heatersSize) {
    qsort(houses, housesSize, sizeof(int), compare);
    qsort(heaters, heatersSize, sizeof(int), compare);

    int maxRadius = 0;
    for (int i = 0; i < housesSize; i++) {
        int house = houses[i];
        int left = 0, right = heatersSize - 1;
        int minRadius = 2147483647;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int heater = heaters[mid];
            int radius = abs(house - heater);

            if (radius < minRadius) {
                minRadius = radius;
            }

            if (heater < house) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (left > 0) {
            int radius = abs(house - heaters[left-1]);
            if (radius < minRadius) {
                minRadius = radius;
            }
        }
        if (left < heatersSize) {
            int radius = abs(house - heaters[left]);
            if (radius < minRadius) {
                minRadius = radius;
            }
        }

        if (minRadius > maxRadius) {
            maxRadius = minRadius;
        }
    }

    return maxRadius;
}