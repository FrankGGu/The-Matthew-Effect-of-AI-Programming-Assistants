#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maximizeTheMinimumPoweredCity(int* cities, int citiesSize, int k) {
    qsort(cities, citiesSize, sizeof(int), compare);
    int left = 0, right = cities[citiesSize - 1] - cities[0];
    int result = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int count = 1;
        int prev = cities[0];

        for (int i = 1; i < citiesSize; i++) {
            if (cities[i] - prev >= mid) {
                count++;
                prev = cities[i];
            }
        }

        if (count >= k) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}