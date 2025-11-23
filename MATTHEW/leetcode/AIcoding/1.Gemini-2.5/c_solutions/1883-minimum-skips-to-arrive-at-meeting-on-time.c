#include <stdlib.h>
#include <math.h>
#include <float.h>

int minSkips(double* dist, int distSize, int speed, int hoursBefore) {
    int n = distSize;

    double* dp = (double*)malloc(n * sizeof(double));
    if (dp == NULL) {
        return -1;
    }

    dp[0] = 0.0;
    for (int j = 1; j < n; ++j) {
        dp[j] = DBL_MAX;
    }

    const double EPSILON = 1e-9;

    for (int i = 0; i < n; ++i) {
        double segment_time = dist[i] / (double)speed;

        for (int j = i; j >= 0; --j) {
            double time_from_prev_j = dp[j];

            if (time_from_prev_j == DBL_MAX) {
                dp[j] = DBL_MAX; 
            } else {
                double current_segment_total_time;
                if (i == n - 1) {
                    current_segment_total_time = time_from_prev_j + segment_time;
                } else {
                    current_segment_total_time = ceil(time_from_prev_j) + segment_time;
                }
                dp[j] = current_segment_total_time;
            }

            if (j > 0) {
                double time_from_prev_j_minus_1 = dp[j-1];
                if (time_from_prev_j_minus_1 != DBL_MAX) {
                    double current_segment_total_time = time_from_prev_j_minus_1 + segment_time;
                    if (current_segment_total_time < dp[j]) {
                        dp[j] = current_segment_total_time;
                    }
                }
            }
        }
    }

    for (int j = 0; j < n; ++j) {
        if (dp[j] <= hoursBefore + EPSILON) { 
            free(dp);
            return j;
        }
    }

    free(dp);
    return -1;
}