#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkOverlap(int radius, int x_center, int y_center, int x1, int y1, int x2, int y2) {
    double closest_x = fmax(x1, fmin(x_center, x2));
    double closest_y = fmax(y1, fmin(y_center, y2));
    double distance = sqrt(pow(x_center - closest_x, 2) + pow(y_center - closest_y, 2));
    return distance <= radius;
}