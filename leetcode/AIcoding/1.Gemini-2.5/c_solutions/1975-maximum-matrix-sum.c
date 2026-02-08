#include <stdlib.h> // For abs
#include <limits.h> // For LLONG_MAX

long long maxMatrixSum(int** matrix, int matrixSize, int* matrixColSize) {
    long long total_abs_sum = 0;
    int negative_count = 0;
    long long min_abs_val = LLONG_MAX;

    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < matrixColSize[i]; j++) {
            int current_val = matrix[i][j];
            if (current_val < 0) {
                negative_count++;
            }
            long long abs_val = abs(current_val); // abs for int, then promoted to long long
            total_abs_sum += abs_val;
            if (abs_val < min_abs_val) {
                min_abs_val = abs_val;
            }
        }
    }

    if (negative_count % 2 == 0) {
        return total_abs_sum;
    } else {
        return total_abs_sum - 2 * min_abs_val;
    }
}