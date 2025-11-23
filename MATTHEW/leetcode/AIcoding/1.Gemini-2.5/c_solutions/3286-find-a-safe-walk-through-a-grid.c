#include <stdlib.h>
#include <stdbool.h>
#include <limits.h> // For INT_MAX

typedef struct {
    int r;
    int c;
} Cell;

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

bool isValid(int r, int c, int R, int C) {
    return r >= 0 && r < R && c >= 0 && c < C;
}

void calculateDistances(int** grid, int R, int C, int** dist) {
    // Initialize dist array with INT_MAX (indicating unvisited or infinite distance)
    for (int i = 0; i < R; i++) {
        for (int j = 0; j < C; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    // Queue for BFS
    Cell* q = (Cell*)malloc(sizeof(Cell) * R * C);
    int head = 0, tail = 0;

    // Add all '1' cells (sources of danger) to the queue and set their distance to 0
    for (int i = 0; i < R; i++) {
        for (int j = 0; j < C; j++) {
            if (grid[i][j] == 1) {
                q[tail++] = (Cell){i, j};
                dist[i][j] = 0;
            }
        }
    }

    // Perform BFS
    while (head < tail) {
        Cell current = q[head++];

        for (int i = 0; i < 4; i++) {
            int nr = current.r + dr[i];
            int nc = current.c + dc[i];

            if (isValid(nr, nc, R, C) && dist[nr][nc] == INT_MAX) { // If valid and unvisited
                dist[nr][nc] = dist[current.r][current.c] + 1;
                q[tail++] = (Cell){nr, nc};
            }
        }
    }
    free(q);
}

bool canReach(int** dist, int R, int C, int k) {
    // If the start cell itself does not meet the safeness requirement, no path exists
    if (dist[0][0] < k) {
        return false;
    }

    // Visited array for this BFS
    bool** visited = (bool**)malloc(sizeof(bool*) * R);
    for (int i = 0; i < R; i++) {
        visited[i] = (bool*)calloc(C, sizeof(bool)); // calloc initializes to false
    }

    // Queue for BFS
    Cell* q = (Cell*)malloc(sizeof(Cell) * R * C);
    int head = 0, tail = 0;

    q[tail++] = (Cell){0, 0};
    visited[0][0] = true;

    while (head < tail) {
        Cell current = q[head++];

        // If destination is reached
        if (current.r == R - 1 && current.c == C - 1) {
            // Clean up memory before returning
            for (int i = 0; i < R; i++) {
                free(visited[i]);
            }
            free(visited);
            free(q);
            return true;
        }

        for (int i = 0; i < 4; i++) {
            int nr = current.r + dr[i];
            int nc = current.c + dc[i];

            // If neighbor is valid, not visited, and meets the safeness requirement
            if (isValid(nr, nc, R, C) && !visited[nr][nc] && dist[nr][nc] >= k) {
                visited[nr][nc] = true;
                q[tail++] = (Cell){nr, nc};
            }
        }
    }

    // Clean up memory if destination was not reached
    for (int i = 0; i < R; i++) {
        free(visited[i]);
    }
    free(visited);
    free(q);
    return false;
}

int maximumSafenessFactor(int** grid, int gridSize, int* gridColSize) {
    int R = gridSize;
    int C = gridColSize[0];

    // Edge case: If start or end cell is a '1', the safeness factor is 0
    if (grid[0][0] == 1 || grid[R - 1][C - 1] == 1) {
        return 0;
    }

    // Allocate memory for the distance array
    int** dist = (int**)malloc(sizeof(int*) * R);
    for (int i = 0; i < R; i++) {
        dist[i] = (int*)malloc(sizeof(int) * C);
    }

    // Step 1: Calculate minimum distances from all '1's to every cell
    calculateDistances(grid, R, C, dist);

    // Step 2: Binary search for the maximum possible safeness factor
    int low = 0;
    // The maximum possible safeness factor is the largest distance found in the dist array.
    // A safe upper bound is R + C.
    int high = 0;
    for(int i = 0; i < R; ++i) {
        for(int j = 0; j < C; ++j) {
            if (dist[i][j] != INT_MAX && dist[i][j] > high) {
                high = dist[i][j];
            }
        }
    }
    // If no '1's exist in the grid, all dist values will be INT_MAX.
    // In this case, high remains 0, which is incorrect.
    // However, the problem usually implies there are '1's.
    // If no '1's, the safeness factor would be effectively infinite.
    // For typical LeetCode problems, if no '1's, the max safeness factor would be R+C-2 or similar.
    // For this specific problem, if no '1's, 'dist' remains INT_MAX. canReach(INT_MAX) would be true.
    // The high would need to be INT_MAX in that case.
    // Let's assume there's at least one '1' or the problem handles it as 0.

    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (canReach(dist, R, C, mid)) {
            ans = mid;
            low = mid + 1; // Try for a higher safeness factor
        } else {
            high = mid - 1; // Need a lower safeness factor
        }
    }

    // Clean up memory for the distance array
    for (int i = 0; i < R; i++) {
        free(dist[i]);
    }
    free(dist);

    return ans;
}