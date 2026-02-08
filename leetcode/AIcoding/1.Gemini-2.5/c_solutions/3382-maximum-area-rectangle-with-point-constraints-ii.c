#include <stdlib.h> // For malloc, qsort, free

struct Point {
    int x;
    int y;
};

int comparePoints(const void *a, const void *b) {
    return ((struct Point*)a)->x - ((struct Point*)b)->x;
}

int insertSorted(int *arr, int size, int val) {
    int i = size - 1;
    while (i >= 0 && arr[i] > val) {
        arr[i+1] = arr[i];
        i--;
    }
    arr[i+1] = val;
    return size + 1;
}

long long maxArea(int** points, int pointsSize, int* pointsColSize, int k) {
    // Convert the input 2D array to an array of Point structs for easier sorting
    struct Point* pts = (struct Point*)malloc(pointsSize * sizeof(struct Point));
    for (int i = 0; i < pointsSize; i++) {
        pts[i].x = points[i][0];
        pts[i].y = points[i][1];
    }

    // Sort points by x-coordinate
    qsort(pts, pointsSize, sizeof(struct Point), comparePoints);

    long long max_area = 0;

    // Allocate a temporary array to store y-coordinates within the current x-strip.
    // This array will be kept sorted. Max size is pointsSize.
    int* y_coords_in_strip = (int*)malloc(pointsSize * sizeof(int));
    // Error handling for malloc, though LeetCode usually guarantees success
    if (y_coords_in_strip == NULL) {
        free(pts);
        return 0; 
    }

    // Outer loop: iterate through all possible left x-boundaries
    for (int i = 0; i < pointsSize; i++) {
        int current_y_size = 0; // Current number of y-coordinates in the strip

        // Inner loop: iterate through all possible right x-boundaries (j >= i)
        for (int j = i; j < pointsSize; j++) {
            // Add the y-coordinate of points[j] to the sorted list
            // This maintains y_coords_in_strip in sorted order.
            current_y_size = insertSorted(y_coords_in_strip, current_y_size, pts[j].y);

            // If we have at least k points in the current x-strip
            if (current_y_size >= k) {
                long long current_width = (long long)pts[j].x - pts[i].x;

                // Use a sliding window of size k on the sorted y-coordinates
                // to find the maximum height (y_top - y_bottom)
                for (int l = 0; l <= current_y_size - k; l++) {
                    long long current_height = (long long)y_coords_in_strip[l + k - 1] - y_coords_in_strip[l];

                    // Update max_area if current rectangle has a larger area
                    if (current_width * current_height > max_area) {
                        max_area = current_width * current_height;
                    }
                }
            }
        }
    }

    // Free dynamically allocated memory
    free(y_coords_in_strip);
    free(pts);

    return max_area;
}