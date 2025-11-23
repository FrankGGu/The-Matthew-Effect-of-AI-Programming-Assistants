#include <math.h>
#include <float.h>

double getMinDistSum(int** positions, int positionsSize, int* positionsColSize) {
    double x = 0, y = 0;
    for (int i = 0; i < positionsSize; i++) {
        x += positions[i][0];
        y += positions[i][1];
    }
    x /= positionsSize;
    y /= positionsSize;

    double step = 100.0;
    double min_dist = DBL_MAX;
    int dirs[4][2] = {{0,1}, {0,-1}, {1,0}, {-1,0}};

    while (step > 1e-6) {
        int found = 0;
        for (int i = 0; i < 4; i++) {
            double nx = x + dirs[i][0] * step;
            double ny = y + dirs[i][1] * step;
            double dist = 0.0;
            for (int j = 0; j < positionsSize; j++) {
                double dx = nx - positions[j][0];
                double dy = ny - positions[j][1];
                dist += sqrt(dx * dx + dy * dy);
            }
            if (dist < min_dist) {
                min_dist = dist;
                x = nx;
                y = ny;
                found = 1;
                break;
            }
        }
        if (!found) {
            step /= 2.0;
        }
    }

    return min_dist;
}