#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSpeedOnTime(int* dist, int distSize, double hour) {
    int left = 1, right = 10000000;
    int ans = -1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        double time = 0.0;
        for (int i = 0; i < distSize - 1; i++) {
            time += ceil((double)dist[i] / mid);
        }
        time += (double)dist[distSize - 1] / mid;

        if (time <= hour) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
}