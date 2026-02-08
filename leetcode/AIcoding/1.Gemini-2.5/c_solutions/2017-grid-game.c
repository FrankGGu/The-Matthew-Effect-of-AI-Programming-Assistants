#include <stdlib.h> // For calloc, free
#include <limits.h> // For LLONG_MAX

long long gridGame(int** grid, int gridSize, int* gridColSize) {
    int n = gridColSize[0];

    // row0_suffix_sum[j] will store the sum of grid[0][j] to grid[0][n-1]
    // row1_prefix_sum[j] will store the sum of grid[1][0] to grid[1][j-1]
    // We use n+1 size for convenience with indexing (e.g., row0_suffix_sum[n] = 0, row1_prefix_sum[0] = 0)
    long long* row0_suffix_sum = (long long*)calloc(n + 1, sizeof(long long));
    long long* row1_prefix_sum = (long long*)calloc(n + 1, sizeof(long long));

    // Calculate suffix sums for row 0
    // row0_suffix_sum[n] is already 0 due to calloc
    for (int j = n - 1; j >= 0; --j) {
        row0_suffix_sum[j] = grid[0][j] + row0_suffix_sum[j + 1];
    }

    // Calculate prefix sums for row 1
    // row1_prefix_sum[0] is already 0 due to calloc
    for (int j = 0; j < n; ++j) {
        row1_prefix_sum[j + 1] = grid[1][j] + row1_prefix_sum[j];
    }

    long long min_robot2_score = LLONG_MAX;

    // Robot 1 chooses a column 'i' to switch from row 0 to row 1.
    // This means Robot 1 collects grid[0][0]...grid[0][i] and grid[1][i]...grid[1][n-1].
    // The remaining points for Robot 2 are:
    // - In row 0: grid[0][i+1]...grid[0][n-1]
    // - In row 1: grid[1][0]...grid[1][i-1]
    // Robot 2 will choose the path that maximizes its score from these two available segments.
    for (int i = 0; i < n; ++i) {
        // Points Robot 2 can collect from row 0 (segment after Robot 1's switch point)
        long long score_from_row0_segment = row0_suffix_sum[i + 1];

        // Points Robot 2 can collect from row 1 (segment before Robot 1's switch point)
        long long score_from_row1_segment = row1_prefix_sum[i];

        // Robot 2 maximizes its score by taking the larger of the two available segments
        long long current_robot2_max_score = (score_from_row0_segment > score_from_row1_segment) ? score_from_row0_segment : score_from_row1_segment;

        // Robot 1 wants to minimize this maximum score that Robot 2 can achieve
        if (current_robot2_max_score < min_robot2_score) {
            min_robot2_score = current_robot2_max_score;
        }
    }

    // Free dynamically allocated memory
    free(row0_suffix_sum);
    free(row1_prefix_sum);

    return min_robot2_score;
}