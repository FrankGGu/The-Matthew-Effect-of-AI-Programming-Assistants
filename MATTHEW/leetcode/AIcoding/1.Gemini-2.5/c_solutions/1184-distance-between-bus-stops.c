#include <stdlib.h> // Required for general utilities, though min/max are implemented manually here

static inline int min(int a, int b) {
    return (a < b) ? a : b;
}

static inline int max(int a, int b) {
    return (a > b) ? a : b;
}

int distanceBetweenBusStops(int* distance, int distanceSize, int start, int destination) {
    int total_distance = 0;
    for (int i = 0; i < distanceSize; ++i) {
        total_distance += distance[i];
    }

    int path1_distance = 0;

    // Determine the actual start and end indices for the first path (clockwise or forward)
    // This ensures we always iterate from the smaller index to the larger one
    int start_idx = min(start, destination);
    int end_idx = max(start, destination);

    for (int i = start_idx; i < end_idx; ++i) {
        path1_distance += distance[i];
    }

    // The second path (counter-clockwise or backward) is the total distance minus the first path's distance
    int path2_distance = total_distance - path1_distance;

    // Return the minimum of the two path distances
    return min(path1_distance, path2_distance);
}