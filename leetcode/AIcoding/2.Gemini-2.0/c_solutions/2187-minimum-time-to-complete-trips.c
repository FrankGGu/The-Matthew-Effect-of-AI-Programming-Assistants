#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long countTrips(int* time, int timeSize, long long givenTime) {
    long long trips = 0;
    for (int i = 0; i < timeSize; i++) {
        trips += givenTime / time[i];
    }
    return trips;
}

long long minimumTime(int* time, int timeSize, int totalTrips) {
    long long left = 1;
    long long right = 1e14;
    long long ans = right;

    while (left <= right) {
        long long mid = left + (right - left) / 2;
        long long trips = countTrips(time, timeSize, mid);

        if (trips >= totalTrips) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
}