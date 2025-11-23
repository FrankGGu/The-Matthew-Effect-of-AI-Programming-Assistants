#include <math.h>

double maxDistance(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize < 2) {
        return 0.0;
    }

    double max_dist_sq = 0.0;

    for (int i = 0; i < pointsSize; ++i) {
        for (int j = i + 1; j < pointsSize; ++j) {
            long long dx = (long long)points[i][0] - points[j][0];
            long long dy = (long long)points[i][1] - points[j][1];
            double current_dist_sq = (double)(dx * dx + dy * dy);

            if (current_dist_sq > max_dist_sq) {
                max_dist_sq = current_dist_sq;
            }
        }
    }

    return sqrt(max_dist_sq);
}