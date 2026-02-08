#include <stdio.h>
#include <stdlib.h>

long long int minTime(int* time, int timeSize, int totalTrips) {
    long long int left = 0;
    long long int right = (long long int)*max_element(time, time + timeSize) * totalTrips;

    while (left < right) {
        long long int mid = left + (right - left) / 2;
        long long int total = 0;
        for (int i = 0; i < timeSize; i++) {
            total += mid / time[i];
            if (total >= totalTrips) break;
        }
        if (total >= totalTrips) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}