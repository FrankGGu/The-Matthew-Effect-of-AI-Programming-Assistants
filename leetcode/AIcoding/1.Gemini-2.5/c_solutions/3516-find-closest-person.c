#include <stddef.h> // For NULL or size_t, though not strictly needed for this problem
#include <stdlib.h> // For general utilities, not strictly needed for this specific solution
#include <stdio.h>  // For debugging with printf, not for submission
#include <limits.h> // For INT_MAX, not needed for this specific solution

int max(int a, int b) {
    return a > b ? a : b;
}

int findClosestPerson(int* seats, int seatsSize) {
    int prev = -1; 
    int max_dist = 0;

    for (int i = 0; i < seatsSize; i++) {
        if (seats[i] == 1) {
            if (prev == -1) {
                max_dist = i;
            } else {
                max_dist = max(max_dist, (i - prev) / 2);
            }
            prev = i;
        }
    }

    max_dist = max(max_dist, seatsSize - 1 - prev);

    return max_dist;
}