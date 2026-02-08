#include <stdlib.h> 
#include <string.h> 

int R_global, C_global, K_global;
int** G_global;
long long count_paths_ans_global;
int first_half_map[15][15][1024]; // r, c, xor_sum -> count

void dfs1(int r, int c, int current_xor) {
    if (r >= R_global || c >= C_global) {
        return;
    }

    current_xor ^= G_global[r][c];

    // Calculate the total number of steps in a path
    // A path from (0,0) to (R-1, C-1) has (R-1) down moves and (C-1) right moves.
    // Total steps = (R-1) + (C-1).
    // The mid_len for dfs1 is total_steps / 2.
    int total_steps = (R_global - 1) + (C_global - 1);
    int mid_len = total_steps / 2;

    // If current cell (r,c) is at the mid_len steps from (0,0)
    if (r + c == mid_len) {
        first_half_map[r][c][current_xor]++;
        return;
    }

    // Move right
    dfs1(r, c + 1, current_xor);
    // Move down
    dfs1(r + 1, c, current_xor);
}

void dfs2(int r, int c, int current_xor) {
    if (r < 0 || c < 0) {
        return;
    }

    current_xor ^= G_global[r][c];

    // Calculate the total number of steps in a path
    int total_steps = (R_global - 1) + (C_global - 1);
    // The number of steps for dfs1 is mid_len_dfs1 = total_steps / 2
    // The number of steps for dfs2 (from end backwards) is mid_len_dfs2 = total_steps - mid_len_dfs1
    int mid_len_dfs1 = total_steps / 2;
    int mid_len_dfs2 = total_steps - mid_len_dfs1; 

    // If current cell (r,c) is at the mid_len_dfs2 steps from (R-1,C-1) backwards
    if ((R_global - 1 - r) + (C_global - 1 - c) == mid_len_dfs2) {
        // Let X1 = XOR sum of path from (0,0) to (r,c) (computed by dfs1)
        // Let X2 = XOR sum of path from (r,c) to (R-1,C-1) (computed by current dfs2)
        // The total XOR sum of a full path is X1 ^ X2 ^ G_global[r][c]
        // (G_global[r][c] is included in both X1 and X2, so it must be XORed once to remove the duplicate)
        // We want X1 ^ X2 ^ G_global[r][c] = K_global
        // Therefore, X1 = K_global ^ X2 ^ G_global[r][c]
        int required_xor_from_start = K_global ^ current_xor ^ G_global[r][c];

        // Ensure required_xor_from_start is within bounds of the map (0 to 1023)
        if (required_xor_from_start >= 0 && required_xor_from_start < 1024) {
            count_paths_ans_global += first_half_map[r][c][required_xor_from_start];
        }
        return;
    }

    // Move up (corresponds to moving down from start)
    dfs2(r - 1, c, current_xor);
    // Move left (corresponds to moving right from start)
    dfs2(r, c - 1, current_xor);
}

long long countPaths(int** grid, int gridSize, int* gridColSize, int k) {
    R_global = gridSize;
    C_global = gridColSize[0]; // All rows have the same number of columns
    G_global = grid;
    K_global = k;
    count_paths_ans_global = 0;

    // Initialize the map for first half paths to all zeros
    memset(first_half_map, 0, sizeof(first_half_map));

    // Start DFS for the first half from (0,0) with initial XOR sum 0
    // The first element grid[0][0] will be XORed inside dfs1
    dfs1(0, 0, 0);

    // Start DFS for the second half from (R_global-1, C_global-1) with initial XOR sum 0
    // The last element grid[R_global-1][C_global-1] will be XORed inside dfs2
    dfs2(R_global - 1, C_global - 1, 0);

    return count_paths_ans_global;
}