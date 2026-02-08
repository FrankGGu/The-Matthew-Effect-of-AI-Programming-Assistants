#include <math.h>

double calculate_total_distance(double cx, double cy, int** positions, int positionsSize) {
    double total_dist = 0.0;
    for (int i = 0; i < positionsSize; i++) {
        double dx = cx - positions[i][0];
        double dy = cy - positions[i][1];
        total_dist += sqrt(dx * dx + dy * dy);
    }
    return total_dist;
}

double getMinDistSum(int** positions, int positionsSize, int* positionsColSize) {
    double current_x = 0.0;
    double current_y = 0.0;

    for (int i = 0; i < positionsSize; i++) {
        current_x += positions[i][0];
        current_y += positions[i][1];
    }
    current_x /= positionsSize;
    current_y /= positionsSize;

    double step_size = 100.0;
    double min_total_dist = calculate_total_distance(current_x, current_y, positions, positionsSize);

    double dx[] = {0, 0, 1, -1, 1, -1, 1, -1};
    double dy[] = {1, -1, 0, 0, 1, -1, -1, 1};

    for (int iter = 0; iter < 50000; iter++) {
        for (int i = 0; i < 8; i++) {
            double next_x = current_x + dx[i] * step_size;
            double next_y = current_y + dy[i] * step_size;

            double new_total_dist = calculate_total_distance(next_x, next_y, positions, positionsSize);

            if (new_total_dist < min_total_dist) {
                min_total_dist = new_total_dist;
                current_x = next_x;
                current_y = next_y;
            }
        }
        step_size *= 0.999;
    }

    return min_total_dist;
}