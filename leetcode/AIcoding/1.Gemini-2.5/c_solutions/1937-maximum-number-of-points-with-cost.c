#include <stdlib.h>
#include <string.h>

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long maxPoints(int** points, int pointsSize, int* pointsColSize) {
    int R = pointsSize;
    int C = pointsColSize[0];

    if (R == 0 || C == 0) {
        return 0;
    }

    long long* prev_dp = (long long*)malloc(C * sizeof(long long));
    long long* current_dp = (long long*)malloc(C * sizeof(long long));
    long long* left_max_val = (long long*)malloc(C * sizeof(long long));
    long long* right_max_val = (long long*)malloc(C * sizeof(long long));

    for (int j = 0; j < C; ++j) {
        prev_dp[j] = points[0][j];
    }

    for (int i = 1; i < R; ++i) {
        left_max_val[0] = prev_dp[0];
        for (int j = 1; j < C; ++j) {
            left_max_val[j] = max(left_max_val[j - 1] - 1, prev_dp[j]);
        }

        right_max_val[C - 1] = prev_dp[C - 1];
        for (int j = C - 2; j >= 0; --j) {
            right_max_val[j] = max(right_max_val[j + 1] - 1, prev_dp[j]);
        }

        for (int j = 0; j < C; ++j) {
            current_dp[j] = points[i][j] + max(left_max_val[j], right_max_val[j]);
        }

        memcpy(prev_dp, current_dp, C * sizeof(long long));
    }

    long long max_points = 0;
    if (C > 0) {
        max_points = prev_dp[0];
        for (int j = 1; j < C; ++j) {
            max_points = max(max_points, prev_dp[j]);
        }
    }

    free(prev_dp);
    free(current_dp);
    free(left_max_val);
    free(right_max_val);

    return max_points;
}