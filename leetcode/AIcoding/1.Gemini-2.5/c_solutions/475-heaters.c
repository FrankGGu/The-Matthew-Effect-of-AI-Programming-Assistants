#include <stdlib.h> // For qsort, abs
#include <limits.h> // For INT_MAX

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int findRadius(int* houses, int housesSize, int* heaters, int heatersSize) {
    // Sort both houses and heaters arrays
    qsort(houses, housesSize, sizeof(int), compare);
    qsort(heaters, heatersSize, sizeof(int), compare);

    int max_radius = 0;
    int heater_idx = 0; // Pointer for the heaters array

    // Iterate through each house to find the minimum radius required for it
    for (int i = 0; i < housesSize; i++) {
        int current_house = houses[i];

        // Advance heater_idx to find the heater that is closest to current_house
        // The loop ensures that heaters[heater_idx] is the largest heater position
        // less than or equal to current_house, or it's the first heater if all heaters
        // are to the right of current_house.
        while (heater_idx < heatersSize - 1 && heaters[heater_idx + 1] <= current_house) {
            heater_idx++;
        }

        // Calculate distance to the heater at heater_idx
        int dist1 = abs(current_house - heaters[heater_idx]);

        // Calculate distance to the next heater (if it exists)
        int dist2 = INT_MAX; // Initialize with a very large value
        if (heater_idx < heatersSize - 1) {
            dist2 = abs(current_house - heaters[heater_idx + 1]);
        }

        // The minimum distance for the current house is the smaller of dist1 and dist2
        int current_min_dist_for_house = min(dist1, dist2);

        // The overall minimum radius is the maximum of these minimum distances
        max_radius = max(max_radius, current_min_dist_for_house);
    }

    return max_radius;
}