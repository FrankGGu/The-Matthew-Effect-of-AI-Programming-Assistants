#include <stdlib.h> // For abs

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maxDistance(int** arrays, int arraysSize, int* arraysColSizes) {
    int max_dist = 0;

    int min_val_so_far = arrays[0][0];
    int max_val_so_far = arrays[0][arraysColSizes[0] - 1];

    for (int i = 1; i < arraysSize; i++) {
        int current_array_min = arrays[i][0];
        int current_array_max = arrays[i][arraysColSizes[i] - 1];

        max_dist = max(max_dist, abs(current_array_max - min_val_so_far));
        max_dist = max(max_dist, abs(max_val_so_far - current_array_min));

        min_val_so_far = min(min_val_so_far, current_array_min);
        max_val_so_far = max(max_val_so_far, current_array_max);
    }

    return max_dist;
}