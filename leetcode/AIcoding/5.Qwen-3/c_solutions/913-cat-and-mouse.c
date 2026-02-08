#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOUSE_WIN 1
#define CAT_WIN 2
#define DRAW 0
#define UNKNOWN -1

int dp[101][101][2];
int g[101][101];

int solve(int mouse, int cat, int turn) {
    if (mouse == 0) return MOUSE_WIN;
    if (mouse == cat) return CAT_WIN;
    if (turn == 200) return DRAW;

    if (dp[mouse][cat][turn % 2] != UNKNOWN) {
        return dp[mouse][cat][turn % 2];
    }

    int is_mouse_turn = turn % 2 == 0;
    int result = is_mouse_turn ? CAT_WIN : MOUSE_WIN;

    for (int next = 0; next < 101; next++) {
        if (g[mouse][next] == 0) continue;

        if (is_mouse_turn) {
            int next_result = solve(next, cat, turn + 1);
            if (next_result == MOUSE_WIN) {
                result = MOUSE_WIN;
                break;
            } else if (next_result == DRAW) {
                result = DRAW;
            }
        } else {
            int next_result = solve(mouse, next, turn + 1);
            if (next_result == CAT_WIN) {
                result = CAT_WIN;
                break;
            } else if (next_result == DRAW) {
                result = DRAW;
            }
        }
    }

    dp[mouse][cat][turn % 2] = result;
    return result;
}

int catMouseGame(int* mouse, int mouseSize, int* cat, int catSize, int** graph, int graphSize, int* graphColSize) {
    for (int i = 0; i < 101; i++) {
        for (int j = 0; j < 101; j++) {
            for (int k = 0; k < 2; k++) {
                dp[i][j][k] = UNKNOWN;
            }
        }
    }

    for (int i = 0; i < graphSize; i++) {
        for (int j = 0; j < graphColSize[i]; j++) {
            g[i][graph[i][j]] = 1;
        }
    }

    return solve(*mouse, *cat, 0);
}