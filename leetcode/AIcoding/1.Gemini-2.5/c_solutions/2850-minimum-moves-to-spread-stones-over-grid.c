#include <stdlib.h> // For abs
#include <limits.h> // For INT_MAX

static int sources_coords[8][2]; // Maximum 8 extra stones
static int targets_coords[8][2]; // Maximum 8 empty cells
static int num_sources;
static int num_targets;
static int min_total_moves;

static void backtrack(int k, int current_cost, int visited_targets_mask) {
    // Base case: all source stones have been assigned to target cells
    if (k == num_sources) {
        if (current_cost < min_total_moves) {
            min_total_moves = current_cost;
        }
        return;
    }

    // Coordinates of the current source stone
    int sr = sources_coords[k][0];
    int sc = sources_coords[k][1];

    // Try to assign the current source stone to each unvisited target cell
    for (int i = 0; i < num_targets; i++) {
        // Check if the i-th target cell has not been visited yet using the bitmask
        if (!((visited_targets_mask >> i) & 1)) {
            int tr = targets_coords[i][0];
            int tc = targets_coords[i][1];

            // Calculate Manhattan distance between source and target
            int dist = abs(sr - tr) + abs(sc - tc);

            // Mark target as visited (by setting the i-th bit) and recurse
            backtrack(k + 1, current_cost + dist, visited_targets_mask | (1 << i));

            // No explicit unmarking is needed for the mask as it's passed by value
            // and the current bit is only set for the recursive call's scope.
        }
    }
}

int minMovesToSpreadStones(int** grid, int gridSize, int* gridColSize) {
    num_sources = 0;
    num_targets = 0;
    min_total_moves = INT_MAX;

    // Populate sources_coords and targets_coords lists
    // Iterate through the 3x3 grid
    for (int r = 0; r < 3; r++) {
        for (int c = 0; c < 3; c++) {
            if (grid[r][c] > 1) {
                // If a cell has more than one stone, it's a source of extra stones
                // Add (r, c) to sources_coords (grid[r][c] - 1) times
                for (int i = 0; i < grid[r][c] - 1; i++) {
                    sources_coords[num_sources][0] = r;
                    sources_coords[num_sources][1] = c;
                    num_sources++;
                }
            } else if (grid[r][c] == 0) {
                // If a cell has zero stones, it's a target needing a stone
                // Add (r, c) to targets_coords once
                targets_coords[num_targets][0] = r;
                targets_coords[num_targets][1] = c;
                num_targets++;
            }
        }
    }

    // If there are no sources (and thus no targets, as total stones are always 9),
    // no moves are needed.
    if (num_sources == 0) {
        return 0;
    }

    // Start the backtracking process
    // k=0: start with the first source stone
    // current_cost=0: initial cost is zero
    // visited_targets_mask=0: initially no target cells are visited
    backtrack(0, 0, 0);

    return min_total_moves;
}