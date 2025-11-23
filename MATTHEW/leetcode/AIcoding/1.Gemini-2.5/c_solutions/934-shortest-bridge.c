#include <stdbool.h>
#include <stdlib.h>

typedef struct {
    int r;
    int c;
} Point;

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

int N_global; // Grid dimension, made global for helper functions

bool isValid(int r, int c) {
    return r >= 0 && r < N_global && c >= 0 && c < N_global;
}

void dfs(int** grid, int r, int c, Point* q, int* q_tail) {
    if (!isValid(r, c) || grid[r][c] != 1) {
        return;
    }

    grid[r][c] = 2; // Mark as visited (part of the first island)
    q[*q_tail].r = r;
    q[*q_tail].c = c;
    (*q_tail)++;

    for (int i = 0; i < 4; i++) {
        dfs(grid, r + dr[i], c + dc[i], q, q_tail);
    }
}

int shortestBridge(int** grid, int gridSize, int* gridColSize) {
    N_global = gridSize;

    // Allocate memory for the BFS queue. Max size is N*N.
    Point* q = (Point*)malloc(sizeof(Point) * N_global * N_global);
    int q_head = 0;
    int q_tail = 0;

    // Phase 1: Find the first island using DFS.
    // Mark its cells as '2' and populate the BFS queue with these cells.
    bool found_first_island = false;
    for (int r = 0; r < N_global; r++) {
        for (int c = 0; c < N_global; c++) {
            if (grid[r][c] == 1) {
                dfs(grid, r, c, q, &q_tail);
                found_first_island = true;
                break; // Found and processed the first island, exit loops
            }
        }
        if (found_first_island) {
            break;
        }
    }

    // Phase 2: Multi-source BFS to expand from the first island
    // and find the shortest path to the second island.
    int distance = 0;
    while (q_head < q_tail) {
        int level_size = q_tail - q_head; // Number of elements at the current level

        for (int i = 0; i < level_size; i++) {
            Point current = q[q_head++];

            for (int k = 0; k < 4; k++) {
                int nr = current.r + dr[k];
                int nc = current.c + dc[k];

                if (isValid(nr, nc)) {
                    if (grid[nr][nc] == 1) {
                        // Found the second island. The current distance is the shortest bridge length.
                        free(q);
                        return distance;
                    }
                    if (grid[nr][nc] == 0) {
                        // Found water ('0'). Mark it as visited ('2') and add to queue for next level.
                        grid[nr][nc] = 2; 
                        q[q_tail].r = nr;
                        q[q_tail].c = nc;
                        q_tail++;
                    }
                }
            }
        }
        distance++; // Increment distance after processing all cells at the current level
    }

    free(q);
    return -1; // Should not be reached given problem constraints (two islands always exist)
}