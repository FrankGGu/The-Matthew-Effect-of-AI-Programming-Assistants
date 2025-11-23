#include <stdbool.h>

#define MAX_LOCATION 1000

bool carPooling(int** trips, int tripsSize, int* tripsColSize, int capacity) {
    int timeline[MAX_LOCATION + 1] = {0};

    for (int i = 0; i < tripsSize; i++) {
        int num_passengers = trips[i][0];
        int from_location = trips[i][1];
        int to_location = trips[i][2];

        timeline[from_location] += num_passengers;
        timeline[to_location] -= num_passengers;
    }

    int current_passengers = 0;
    for (int i = 0; i <= MAX_LOCATION; i++) {
        current_passengers += timeline[i];
        if (current_passengers > capacity) {
            return false;
        }
    }

    return true;
}