#include <vector>
#include <string>
#include <cstring> // For memset

using namespace std;

class Solution {
public:
    int R, C;
    vector<string> grid;
    int mouseJump, catJump;
    int food_r, food_c;

    // States: 0 for Draw, 1 for Mouse Win, 2 for Cat Win
    static const int DRAW = 0;
    static const int MOUSE_WIN = 1;
    static const int CAT_WIN = 2;

    // memo[mouse_row][mouse_col][cat_row][cat_col][turn][k]
    // turn: 0 for mouse, 1 for cat
    // k: number of moves made so far
    int memo[8][8][8][8][2][129]; // Max R,C = 8, so 2*R*C = 128 moves

    int dr[4] = {-1, 1, 0, 0};
    int dc[4] = {0, 0, -1, 1};

    int dfs(int mr, int mc, int cr, int cc, int turn, int k) {
        // Game went on too long, it's a draw
        if (k >= 2 * R * C) { // A common heuristic for maximum moves before a cycle implies draw
            return DRAW;
        }

        // Base cases
        // Mouse reaches food: Mouse wins
        if (mr == food_r && mc == food_c) {
            return MOUSE_WIN;
        }
        // Cat catches mouse: Cat wins
        if (mr == cr && mc == cc) {
            return CAT_WIN;
        }
        // Cat reaches food: Cat wins
        if (cr == food_r && cc == food_c) {
            return CAT_WIN;
        }

        // Check memoization
        if (memo[mr][mc][cr][cc][turn][k] != -1) {
            return memo[mr][mc][cr][cc][turn][k];
        }

        int current_result;

        if (turn == 0) { // Mouse's turn
            bool can_mouse_win = false;
            bool can_mouse_draw = false;

            // Mouse must make a move (cannot stay put)
            bool made_any_move = false; 

            // Try all possible moves for the mouse
            for (int d = 0; d < 4; ++d) { // 4 directions
                for (int j = 1; j <= mouseJump; ++j) { // Jump distance, from 1 to mouseJump
                    int nmr = mr + dr[d] * j;
                    int nmc = mc + dc[d] * j;

                    // Check boundaries and obstacles
                    if (nmr < 0 || nmr >= R || nmc < 0 || nmc >= C || grid[nmr][nmc] == '#') {
                        break; // Cannot jump past an obstacle, or out of bounds
                    }

                    made_any_move = true; // At least one valid move exists

                    int res = dfs(nmr, nmc, cr, cc, 1, k + 1); // Next turn is cat's
                    if (res == MOUSE_WIN) {
                        can_mouse_win = true;
                        break; // Mouse found a winning move, takes it
                    }
                    if (res == DRAW) {
                        can_mouse_draw = true;
                    }
                }
                if (can_mouse_win) break; // Optimization: if mouse found a winning move, no need to check further
            }

            if (!made_any_move) { // Mouse has no valid moves
                current_result = CAT_WIN; // Mouse loses
            } else if (can_mouse_win) {
                current_result = MOUSE_WIN;
            } else if (can_mouse_draw) {
                current_result = DRAW;
            } else {
                current_result = CAT_WIN; // All moves lead to cat winning
            }

        } else { // Cat's turn
            bool can_cat_win = false;
            bool can_cat_draw = false;

            // Cat must make a move
            bool made_any_move = false;

            // Try all possible moves for the cat
            for (int d = 0; d < 4; ++d) { // 4 directions
                for (int j = 1; j <= catJump; ++j) { // Jump distance, from 1 to catJump
                    int ncr = cr + dr[d] * j;
                    int ncc = cc + dc[d] * j;

                    // Check boundaries and obstacles
                    if (ncr < 0 || ncr >= R || ncc < 0 || ncc >= C || grid[ncr][ncc] == '#') {
                        break; // Cannot jump past an obstacle, or out of bounds
                    }

                    made_any_move = true; // At least one valid move exists

                    int res = dfs(mr, mc, ncr, ncc, 0, k + 1); // Next turn is mouse's
                    if (res == CAT_WIN) { // Cat wins if mouse loses in the next state
                        can_cat_win = true;
                        break; // Cat found a winning move, takes it
                    }
                    if (res == DRAW) {
                        can_cat_draw = true;
                    }
                }
                if (can_cat_win) break; // Optimization: if cat found a winning move, no need to check further
            }

            if (!made_any_move) { // Cat has no valid moves
                current_result = MOUSE_WIN; // Cat loses
            } else if (can_cat_win) {
                current_result = CAT_WIN;
            } else if (can_cat_draw) {
                current_result = DRAW;
            } else {
                current_result = MOUSE_WIN; // All moves lead to mouse winning (cat loses)
            }
        }

        return memo[mr][mc][cr][cc][turn][k] = current_result;
    }

    bool canMouseWin(vector<string>& grid_param, int mouseJump_param, int catJump_param) {
        grid = grid_param;
        mouseJump = mouseJump_param;
        catJump = catJump_param;

        R = grid.size();
        C = grid[0].size();

        int mouse_start_r = -1, mouse_start_c = -1;
        int cat_start_r = -1, cat_start_c = -1;

        // Find initial positions and food
        for (int i = 0; i < R; ++i) {
            for (int j = 0; j < C; ++j) {
                if (grid[i][j] == 'M') {
                    mouse_start_r = i;
                    mouse_start_c = j;
                } else if (grid[i][j] == 'C') {
                    cat_start_r = i;
                    cat_start_c = j;
                } else if (grid[i][j] == 'F') {
                    food_r = i;
                    food_c = j;
                }
            }
        }

        // Initialize memoization table with -1 (unvisited)
        memset(memo, -1, sizeof(memo));

        // Start the game with mouse's turn, 0 moves
        return dfs(mouse_start_r, mouse_start_c, cat_start_r, cat_start_c, 0, 0) == MOUSE_WIN;
    }
};