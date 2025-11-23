#include <stdlib.h> // Required for malloc, calloc, free

double knightProbability(int n, int k, int row, int column) {
    if (k == 0) {
        return 1.0;
    }

    double** dp_prev = (double**)malloc(n * sizeof(double*));
    double** dp_curr = (double**)malloc(n * sizeof(double*));
    for (int i = 0; i < n; i++) {
        dp_prev[i] = (double*)calloc(n, sizeof(double)); // calloc initializes to 0.0
        dp_curr[i] = (double*)calloc(n, sizeof(double));
    }

    dp_prev[row][column] = 1.0;

    int dr[] = {-2, -2, -1, -1, 1, 1, 2, 2};
    int dc[] = {-1, 1, -2, 2, -2, 2, -1, 1};

    for (int s = 1; s <= k; s++) {
        // Clear dp_curr for the current step
        for (int r = 0; r < n; r++) {
            for (int c = 0; c < n; c++) {
                dp_curr[r][c] = 0.0;
            }
        }

        for (int r = 0; r < n; r++) {
            for (int c = 0; c < n; c++) {
                if (dp_prev[r][c] > 0) { // Only process cells with non-zero probability
                    for (int i = 0; i < 8; i++) {
                        int nr = r + dr[i];
                        int nc = c + dc[i];

                        if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                            dp_curr[nr][nc] += dp_prev[r][c] / 8.0;
                        }
                    }
                }
            }
        }

        // Swap dp_prev and dp_curr pointers for the next iteration
        double** temp = dp_prev;
        dp_prev = dp_curr;
        dp_curr = temp;
    }

    double total_probability = 0.0;
    for (int r = 0; r < n; r++) {
        for (int c = 0; c < n; c++) {
            total_probability += dp_prev[r][c]; // dp_prev holds the probabilities after k steps
        }
    }

    // Free allocated memory
    for (int i = 0; i < n; i++) {
        free(dp_prev[i]);
        free(dp_curr[i]);
    }
    free(dp_prev);
    free(dp_curr);

    return total_probability;
}