#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minSpeedOnTime(int* dist, int distSize, int hour) {
    if (distSize == 0) return -1;
    if (distSize == 1) {
        return (int)ceil((double)dist[0] / hour);
    }

    int left = 1;
    int right = INT_MAX;

    while (left < right) {
        int mid = left + (right - left) / 2;
        double time = 0.0;

        for (int i = 0; i < distSize - 1; i++) {
            time += (double)dist[i] / mid;
        }
        time += (double)dist[distSize - 1] / mid;

        if (time <= hour) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}