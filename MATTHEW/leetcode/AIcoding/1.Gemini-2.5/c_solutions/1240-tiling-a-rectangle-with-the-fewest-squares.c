#include <stdbool.h>

static bool grid[13][13];
static int min_squares_found;
static int M_dim, N_dim;

static bool find_first_empty(int* r, int* c) {
    for (int i = 0; i < M_dim; ++i) {
        for (int j = 0; j < N_dim; ++j) {
            if (!grid[i][j]) {
                *r = i;
                *c = j;
                return true;
            }
        }
    }
    return false; // All cells are filled
}

static bool can_place(int r, int c, int s) {
    if (r + s > M_dim || c + s > N_dim) {
        return false; // Square goes out of bounds
    }
    for (int i = r; i < r + s; ++i) {
        for (int j = c; j < c + s; ++j) {
            if (grid[i][j]) {
                return false; // Cell is already occupied
            }
        }
    }
    return true;
}

static void toggle_square(int r, int c, int s, bool fill) {
    for (int i = r; i < r + s; ++i) {
        for (int j = c; j < c + s; ++j) {
            grid[i][j] = fill;
        }
    }
}

static void solve(int current_squares_count) {
    // Pruning: If the current path already uses more squares than the best solution found so far,
    // there's no need to continue this path.
    if (current_squares_count >= min_squares_found) {
        return;
    }

    int r, c;
    // Find the first empty cell to place a new square.
    if (!find_first_empty(&r, &c)) {
        // If no empty cell is found, the grid is fully tiled.
        // Update the minimum squares found if this path used fewer squares.
        min_squares_found = current_squares_count;
        return;
    }

    // Determine the maximum possible size for a square that can be placed at (r, c).
    int max_s = (M_dim - r < N_dim - c) ? (M_dim - r) : (N_dim - c);

    // Try placing squares of different sizes, from largest to smallest, at (r, c).
    // Trying larger squares first can help find an optimal solution faster,
    // leading to more effective pruning.
    for (int s = max_s; s >= 1; --s) {
        if (can_place(r, c, s)) {
            toggle_square(r, c, s, true); // Place the square
            solve(current_squares_count + 1); // Recurse with one more square
            toggle_square(r, c, s, false); // Backtrack: remove the square to explore other possibilities
        }
    }
}

int tilingRectangle(int m, int n) {
    M_dim = m;
    N_dim = n;

    // Initialize the grid to all false (empty).
    for (int i = 0; i < M_dim; ++i) {
        for (int j = 0; j < N_dim; ++j) {
            grid[i][j] = false;
        }
    }

    // Initialize min_squares_found to an upper bound.
    // For m, n <= 13, the maximum number of squares needed is known to be 6 (e.g., for 11x13).
    // So, 7 is a safe initial upper bound that enables effective pruning.
    min_squares_found = 7;

    // Start the DFS from 0 squares.
    solve(0);

    return min_squares_found;
}