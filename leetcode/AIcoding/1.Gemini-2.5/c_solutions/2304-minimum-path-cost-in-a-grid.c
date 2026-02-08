#include <limits.h> // Required for INT_MAX

int minPathCost(int** grid, int gridRowSize, int* gridColSize, int** moveCost, int moveCostRowSize, int* moveCostColSize) {
    int m = gridRowSize;
    int n = gridColSize[0];

    int dp_prev[n];
    int dp_curr[n];

    // Initialize dp_prev with the costs of the first row
    for (int j = 0; j < n; j++) {
        dp_prev[j] = grid[0][j];
    }

    // Iterate through the grid rows starting from the second row
    for (int i = 1; i < m; i++) {
        // For each cell in the current row (i, j)
        for (int j = 0; j < n; j++) {
            int min_cost_from_prev_row = INT_MAX;

            // Calculate the minimum cost to reach (i, j) from any cell in the previous row (i-1, prev_j)
            for (int prev_j = 0; prev_j < n; prev_j++) {
                // dp_prev[prev_j] is the minimum cost to reach cell (i-1, prev_j)
                // grid[i-1][prev_j] is the value of the cell (i-1, prev_j)
                // moveCost[grid[i-1][prev_j]][j] is the cost to move from value grid[i-1][prev_j] to column j
                int current_path_cost = dp_prev[prev_j] + moveCost[grid[i-1][prev_j]][j];
                if (current_path_cost < min_cost_from_prev_row) {
                    min_cost_from_prev_row = current_path_cost;
                }
            }
            // The total cost to reach (i, j) is the minimum cost from the previous row plus the value of grid[i][j]
            dp_curr[j] = grid[i][j] + min_cost_from_prev_row;
        }
        // Update dp_prev for the next iteration
        for (int j = 0; j < n; j++) {
            dp_prev[j] = dp_curr[j];
        }
    }

    // After processing all rows, dp_prev contains the minimum costs to reach cells in the last row
    int min_total_path_cost = INT_MAX;
    for (int j = 0; j < n; j++) {
        if (dp_prev[j] < min_total_path_cost) {
            min_total_path_cost = dp_prev[j];
        }
    }

    return min_total_path_cost;
}