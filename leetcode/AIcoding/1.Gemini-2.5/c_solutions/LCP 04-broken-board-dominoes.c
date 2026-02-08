#include <stdbool.h>
#include <stdlib.h>

#define MAX_CELLS 256

int adj[MAX_CELLS][4];
int adj_count[MAX_CELLS];

int matchR[MAX_CELLS];

bool visited[MAX_CELLS];

int R_global, C_global;

int get_id(int r, int c) {
    return r * C_global + c;
}

bool dfs(int u) {
    for (int i = 0; i < adj_count[u]; ++i) {
        int v = adj[u][i];
        if (!visited[v]) {
            visited[v] = true;
            if (matchR[v] == -1 || dfs(matchR[v])) {
                matchR[v] = u;
                return true;
            }
        }
    }
    return false;
}

int maxDominoes(int** board, int boardSize, int* boardColSize) {
    R_global = boardSize;
    if (R_global == 0) {
        return 0;
    }
    C_global = boardColSize[0];
    if (C_global == 0) {
        return 0;
    }

    int total_cells = R_global * C_global;

    for (int i = 0; i < total_cells; ++i) {
        adj_count[i] = 0;
    }

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    for (int r = 0; r < R_global; ++r) {
        for (int c = 0; c < C_global; ++c) {
            if (board[r][c] == 1) {
                continue;
            }

            if ((r + c) % 2 == 0) {
                int u_id = get_id(r, c);
                for (int i = 0; i < 4; ++i) {
                    int nr = r + dr[i];
                    int nc = c + dc[i];

                    if (nr >= 0 && nr < R_global && nc >= 0 && nc < C_global && board[nr][nc] == 0) {
                        int v_id = get_id(nr, nc);
                        adj[u_id][adj_count[u_id]++] = v_id;
                    }
                }
            }
        }
    }

    for (int i = 0; i < total_cells; ++i) {
        matchR[i] = -1;
    }

    int result = 0;
    for (int r = 0; r < R_global; ++r) {
        for (int c = 0; c < C_global; ++c) {
            if (board[r][c] == 0 && (r + c) % 2 == 0) {
                int u_id = get_id(r, c);
                for (int i = 0; i < total_cells; ++i) {
                    visited[i] = false;
                }
                if (dfs(u_id)) {
                    result++;
                }
            }
        }
    }

    return result;
}