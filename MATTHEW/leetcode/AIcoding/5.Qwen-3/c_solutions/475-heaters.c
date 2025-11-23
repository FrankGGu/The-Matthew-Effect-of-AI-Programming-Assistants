#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findRadius(int* houses, int housesSize, int* heaters, int heatersSize) {
    qsort(heaters, heatersSize, sizeof(int), compare);
    int maxRadius = 0;
    for (int i = 0; i < housesSize; i++) {
        int left = 0;
        int right = heatersSize - 1;
        int minDist = INT_MAX;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (heaters[mid] == houses[i]) {
                minDist = 0;
                break;
            } else if (heaters[mid] < houses[i]) {
                left = mid + 1;
                minDist = houses[i] - heaters[mid];
            } else {
                right = mid - 1;
                minDist = heaters[mid] - houses[i];
            }
        }
        if (minDist < maxRadius) {
            maxRadius = minDist;
        }
    }
    return maxRadius;
}