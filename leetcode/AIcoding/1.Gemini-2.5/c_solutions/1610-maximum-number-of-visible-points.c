#include <stdlib.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

static int compareDoubles(const void* a, const void* b) {
    double valA = *(const double*)a;
    double valB = *(const double*)b;
    if (valA < valB) return -1;
    if (valA > valB) return 1;
    return 0;
}

static int max(int a, int b) {
    return a > b ? a : b;
}

int maxVisiblePoints(int** points, int pointsSize, int* pointsColSize, int angle, int* location) {
    double* angles = NULL;
    int angles_count = 0;
    int angles_capacity = 10; 

    int same_location_points = 0;

    angles = (double*)malloc(angles_capacity * sizeof(double));

    for (int i = 0; i < pointsSize; i++) {
        int dx = points[i][0] - location[0];
        int dy = points[i][1] - location[1];

        if (dx == 0 && dy == 0) {
            same_location_points++;
        } else {
            double current_angle_rad = atan2(dy, dx);
            double current_angle_deg = current_angle_rad * 180.0 / M_PI;

            if (current_angle_deg < 0) {
                current_angle_deg += 360.0;
            }

            if (angles_count == angles_capacity) {
                angles_capacity *= 2;
                double* new_angles = (double*)realloc(angles, angles_capacity * sizeof(double));
                if (new_angles == NULL) {
                    free(angles);
                    return 0; 
                }
                angles = new_angles;
            }
            angles[angles_count++] = current_angle_deg;
        }
    }

    if (angles_count == 0) {
        free(angles);
        return same_location_points;
    }

    qsort(angles, angles_count, sizeof(double), compareDoubles);

    int original_angles_count = angles_count;
    angles_capacity = angles_count * 2;
    double* new_angles_extended = (double*)realloc(angles, angles_capacity * sizeof(double));
    if (new_angles_extended == NULL) {
        free(angles);
        return 0; 
    }
    angles = new_angles_extended;

    for (int i = 0; i < original_angles_count; i++) {
        angles[angles_count++] = angles[i] + 360.0;
    }

    int max_visible = 0;
    int left = 0;
    for (int right = 0; right < angles_count; right++) {
        while (angles[right] - angles[left] > angle) {
            left++;
        }
        max_visible = max(max_visible, right - left + 1);
    }

    free(angles);
    return max_visible + same_location_points;
}