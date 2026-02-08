#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int br, bc; // Box position
    int pr, pc; // Player position
    int pushes; // Number of box pushes
} State;

int R_global, C_global;
char** Grid_global;

int dist[20][20][20][20];

State queue[20 * 20 * 20 * 20];
int head, tail;

bool can_reach(int start_pr, int start_pc, int target_pr, int target_pc, int box_r, int box_c) {
    if (start_pr == target_pr && start_pc == target_pc) {
        return true;
    }

    bool visited_player[20][20]; // Max grid size is 20x20
    for (int i = 0; i < R_global; ++i) {
        for (int j = 0; j < C_global; ++j) {
            visited_player[i][j] = false;
        }
    }

    int q_player_r[20 * 20];
    int q_player_c[20 * 20];
    int p_head = 0, p_tail = 0;

    q_player_r[p_tail] = start_pr;
    q_player_c[p_tail] = start_pc;
    p_tail++;
    visited_player[start_pr][start_pc] = true;

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    while (p_head < p_tail) {
        int r = q_player_r[p_head];
        int c = q_player_c[p_head];
        p_head++;

        for (int i = 0; i < 4; ++i) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < R_global && nc >= 0 && nc < C_global &&
                Grid_global[nr][nc] != '#' &&
                !(nr == box_r && nc == box_c) &&
                !visited_player[nr][nc]) {

                if (nr == target_pr && nc == target_pc) {
                    return true;
                }
                q_player_r[p_tail] = nr;
                q_player_c[p_tail] = nc;
                p_tail++;
                visited_player[nr][nc] = true;
            }
        }
    }
    return false;
}

int minPushBox(char** grid, int gridSize, int* gridColSize) {
    R_global = gridSize;
    C_global = gridColSize[0];
    Grid_global = grid;

    int p0r, p0c, b0r, b0c, tr, tc;
    p0r = p0c = b0r = b0c = tr = tc = -1;

    for (int r = 0; r < R_global; ++r) {
        for (int c = 0; c < C_global; ++c) {
            if (grid[r][c] == 'S') {
                p0r = r; p0c = c;
            } else if (grid[r][c] == 'B') {
                b0r = r; b0c = c;
            } else if (grid[r][c] == 'T') {
                tr = r; tc = c;
            }
        }
    }

    memset(dist, -1, sizeof(dist));

    head = 0;
    tail = 0;

    queue[tail] = (State){.br = b0r, .bc = b0c, .pr = p0r, .pc = p0c, .pushes = 0};
    tail++;
    dist[b0r][b0c][p0r][p0c] = 0;

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    while (head < tail) {
        State current = queue[head];
        head++;

        if (current.br == tr && current.bc == tc) {
            return current.pushes;
        }

        for (int i = 0; i < 4; ++i) {
            int nbr = current.br + dr[i];
            int nbc = current.bc + dc[i];

            int push_pr = current.br - dr[i];
            int push_pc = current.bc - dc[i];

            if (nbr < 0 || nbr >= R_global || nbc < 0 || nbc >= C_global ||
                Grid_global[nbr][nbc] == '#') {
                continue;
            }

            if (push_pr < 0 || push_pr >= R_global || push_pc < 0 || push_pc >= C_global ||
                Grid_global[push_pr][push_pc] == '#') {
                continue;
            }

            if (can_reach(current.pr, current.pc, push_pr, push_pc, current.br, current.bc)) {
                int npr = current.br;
                int npc = current.bc;

                if (dist[nbr][nbc][npr][npc] == -1) {
                    dist[nbr][nbc][npr][npc] = current.pushes + 1;
                    queue[tail] = (State){.br = nbr, .bc = nbc, .pr = npr, .pc = npc, .pushes = current.pushes + 1};
                    tail++;
                }
            }
        }
    }

    return -1;
}