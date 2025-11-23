#include <stdbool.h>
#include <string.h> // For memset

#define MAX_DIM 3

typedef struct {
    int state;
    int flips;
} QueueNode;

QueueNode queue[1 << (MAX_DIM * MAX_DIM)]; // Max 2^9 = 512 states
int head = 0;
int tail = 0;

bool visited[1 << (MAX_DIM * MAX_DIM)]; // Max 512 states

int dr[] = {0, 0, 0, 1, -1};
int dc[] = {0, 1, -1, 0, 0};

int minFlips(int** mat, int matSize, int* matColSize) {
    int m = matSize;
    int n = matColSize[0];

    // Calculate initial state as an integer
    // Each cell (r, c) corresponds to bit (r * n + c)
    int initialState = 0;
    for (int r = 0; r < m; r++) {
        for (int c = 0; c < n; c++) {
            if (mat[r][c] == 1) {
                initialState |= (1 << (r * n + c));
            }
        }
    }

    // Initialize BFS
    head = 0;
    tail = 0;
    // Clear visited array
    memset(visited, 0, sizeof(visited));

    // Add initial state to queue
    queue[tail++] = (QueueNode){initialState, 0};
    visited[initialState] = true;

    while (head < tail) {
        QueueNode current = queue[head++];

        // If current state is all zeros, we found the minimum flips
        if (current.state == 0) {
            return current.flips;
        }

        // Try flipping each cell (r, c) in the matrix
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                int nextState = current.state;

                // Toggle current cell and its neighbors
                for (int i = 0; i < 5; i++) {
                    int nr = r + dr[i];
                    int nc = c + dc[i];

                    // Check if the neighbor is within matrix bounds
                    if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                        // Toggle the corresponding bit
                        nextState ^= (1 << (nr * n + nc));
                    }
                }

                // If this nextState has not been visited, add it to the queue
                if (!visited[nextState]) {
                    visited[nextState] = true;
                    queue[tail++] = (QueueNode){nextState, current.flips + 1};
                }
            }
        }
    }

    // If the queue becomes empty and the target state (all zeros) was not reached,
    // it's impossible to convert the matrix to a zero matrix.
    return -1;
}