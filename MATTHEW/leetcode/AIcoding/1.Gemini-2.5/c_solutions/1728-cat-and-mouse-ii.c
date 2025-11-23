#include <stdbool.h>
#include <string.h> // For memset

int R_global, C_global;
int MOUSE_JUMP_global, CAT_JUMP_global;
int FOOD_R_global, FOOD_C_global;
char** GRID_global;

int dp[64][64][2][257];

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

#define MAX_GAME_MOVES 256

bool isValid(int r, int c) {
    return r >= 0 && r < R_global && c >= 0 && c < C_global && GRID_global[r][c] != '#';
}

int solve(int mr, int mc, int cr, int cc, int turn, int moves) {
    // Base cases (winning conditions)
    if (mr == FOOD_R_global && mc == FOOD_C_global) return 1; // Mouse reaches food
    if (cr == FOOD_R_global && cc == FOOD_C_global) return 2; // Cat reaches food
    if (mr == cr && mc == cc) return 2;                       // Cat catches mouse

    // Draw condition due to "very long time" (cycle detection and game length limit)
    if (moves >= MAX_GAME_MOVES) return 0;

    // Memoization check
    int mouse_idx = mr * C_global + mc;
    int cat_idx = cr * C_global + cc;
    if (dp[mouse_idx][cat_idx][turn][moves] != -1) {
        return dp[mouse_idx][cat_idx][turn][moves];
    }

    int current_player_outcome;

    if (turn == 0) { // Mouse's turn
        current_player_outcome = 2; // Assume Cat wins (worst case for Mouse)

        // Mouse can stay in place (k=0) or move up to MOUSE_JUMP_global steps
        for (int k = 0; k <= MOUSE_JUMP_global; ++k) {
            // If k=0, it means staying in place. Only one "direction" for that.
            // If k>0, iterate 4 directions.
            int num_dirs = (k == 0) ? 1 : 4; 

            for (int i = 0; i < num_dirs; ++i) {
                int next_mr = mr;
                int next_mc = mc;

                if (k > 0) { // Only move if k > 0
                    next_mr = mr + dr[i] * k;
                    next_mc = mc + dc[i] * k;
                }

                // Check if the path is clear (no walls in between)
                bool path_clear = true;
                if (k > 1) { // Only need to check intermediate steps if moving more than 1 cell
                    for (int step = 1; step < k; ++step) {
                        if (!isValid(mr + dr[i] * step, mc + dc[i] * step)) {
                            path_clear = false;
                            break;
                        }
                    }
                }

                if (path_clear && isValid(next_mr, next_mc)) {
                    // Mouse cannot move to a cell occupied by the Cat
                    if (next_mr == cr && next_mc == cc) continue;

                    int outcome = solve(next_mr, next_mc, cr, cc, 1, moves + 1);

                    if (outcome == 1) { // Mouse found a winning move
                        dp[mouse_idx][cat_idx][turn][moves] = 1;
                        return 1;
                    }
                    if (outcome == 0) { // Mouse found a drawing move
                        current_player_outcome = 0; // Prioritize draw over lose
                    }
                }
            }
        }
        dp[mouse_idx][cat_idx][turn][moves] = current_player_outcome;
        return current_player_outcome;

    } else { // Cat's turn (turn == 1)
        current_player_outcome = 1; // Assume Mouse wins (worst case for Cat)

        // Cat can stay in place (k=0) or move up to CAT_JUMP_global steps
        for (int k = 0; k <= CAT_JUMP_global; ++k) {
            int num_dirs = (k == 0) ? 1 : 4;

            for (int i = 0; i < num_dirs; ++i) {
                int next_cr = cr;
                int next_cc = cc;
                if (k > 0) {
                    next_cr = cr + dr[i] * k;
                    next_cc = cc + dc[i] * k;
                }

                // Check if the path is clear (no walls in between)
                bool path_clear = true;
                if (k > 1) {
                    for (int step = 1; step < k; ++step) {
                        if (!isValid(cr + dr[i] * step, cc + dc[i] * step)) {
                            path_clear = false;
                            break;
                        }
                    }
                }

                if (path_clear && isValid(next_cr, next_cc)) {
                    // Cat cannot move to food if food is already occupied by mouse
                    if (next_cr == FOOD_R_global && next_cc == FOOD_C_global && mr == FOOD_R_global && mc == FOOD_C_global) {
                        continue;
                    }

                    int outcome = solve(mr, mc, next_cr, next_cc, 0, moves + 1);

                    if (outcome == 2) { // Cat found a winning move
                        dp[mouse_idx][cat_idx][turn][moves] = 2;
                        return 2;
                    }
                    if (outcome == 0) { // Cat found a drawing move
                        current_player_outcome = 0; // Prioritize draw over lose
                    }
                }
            }
        }
        dp[mouse_idx][cat_idx][turn][moves] = current_player_outcome;
        return current_player_outcome;
    }
}

bool canMouseWin(char** grid, int gridSize, int* gridColSize, int mouseJump, int catJump) {
    GRID_global = grid;
    R_global = gridSize;
    C_global = gridColSize[0];
    MOUSE_JUMP_global = mouseJump;
    CAT_JUMP_global = catJump;

    int start_mr, start_mc, start_cr, start_cc;

    // Find starting positions and food
    for (int r = 0; r < R_global; ++r) {
        for (int c = 0; c < C_global; ++c) {
            if (grid[r][c] == 'M') {
                start_mr = r;
                start_mc = c;
            } else if (grid[r][c] == 'C') {
                start_cr = r;
                start_cc = c;
            } else if (grid[r][c] == 'F') {
                FOOD_R_global = r;
                FOOD_C_global = c;
            }
        }
    }

    // Initialize DP table with -1 (unvisited)
    memset(dp, -1, sizeof(dp));

    // Start the game simulation
    // Mouse moves first (turn = 0), 0 moves elapsed
    int result = solve(start_mr, start_mc, start_cr, start_cc, 0, 0);

    return result == 1; // Mouse wins if result is 1
}