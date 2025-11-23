#include <stdlib.h>
#include <stdbool.h>

void dfs(int** grid, int n, int m, int r, int c, int island_id, int* current_size) {
    if (r < 0 || r >= n || c < 0 || c >= m || grid[r][c] != 1) {
        return;
    }

    grid[r][c] = island_id;
    (*current_size)++;

    dfs(grid, n, m, r + 1, c, island_id, current_size);
    dfs(grid, n, m, r - 1, c, island_id, current_size);
    dfs(grid, n, m, r, c + 1, island_id, current_size);
    dfs(grid, n, m, r, c - 1, island_id, current_size);
}

int max(int a, int b) {
    return a > b ? a : b;
}

int largestIsland(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    if (n == 0) return 0;
    int m = gridColSize[0];
    if (m == 0) return 0;

    int island_id_counter = 2;
    int* island_sizes = (int*)calloc(n * m + 2, sizeof(int)); 
    if (island_sizes == NULL) return 0;

    int max_overall_size = 0;
    bool has_zero = false;

    for (int r = 0; r < n; r++) {
        for (int c = 0; c < m; c++) {
            if (grid[r][c] == 1) {
                int current_island_size = 0;
                dfs(grid, n, m, r, c, island_id_counter, &current_island_size);
                island_sizes[island_id_counter] = current_island_size;
                max_overall_size = max(max_overall_size, current_island_size);
                island_id_counter++;
            } else if (grid[r][c] == 0) {
                has_zero = true;
            }
        }
    }

    if (!has_zero) {
        free(island_sizes);
        return max_overall_size;
    }

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    for (int r = 0; r < n; r++) {
        for (int c = 0; c < m; c++) {
            if (grid[r][c] == 0) {
                int current_potential_size = 1;

                int neighbor_ids[4];
                int neighbor_count = 0;

                for (int i = 0; i < 4; i++) {
                    int nr = r + dr[i];
                    int nc = c + dc[i];

                    if (nr >= 0 && nr < n && nc >= 0 && nc < m && grid[nr][nc] > 1) {
                        int id = grid[nr][nc];
                        bool already_seen = false;
                        for (int k = 0; k < neighbor_count; k++) {
                            if (neighbor_ids[k] == id) {
                                already_seen = true;
                                break;
                            }
                        }
                        if (!already_seen) {
                            neighbor_ids[neighbor_count++] = id;
                            current_potential_size += island_sizes[id];
                        }
                    }
                }
                max_overall_size = max(max_overall_size, current_potential_size);
            }
        }
    }

    free(island_sizes);
    return max_overall_size;
}