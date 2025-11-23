#include <stdlib.h> // For malloc, free
#include <stdbool.h> // For bool

typedef struct {
    int r;
    int c;
    int dist;
} State;

#define MAX_QUEUE_SIZE (200 * 200) 
State queue[MAX_QUEUE_SIZE];
int head = 0;
int tail = 0;

void enqueue(int r, int c, int dist) {
    queue[tail].r = r;
    queue[tail].c = c;
    queue[tail].dist = dist;
    tail = (tail + 1) % MAX_QUEUE_SIZE;
}

State dequeue() {
    State s = queue[head];
    head = (head + 1) % MAX_QUEUE_SIZE;
    return s;
}

bool is_empty() {
    return head == tail;
}

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

int shortestPath(char** maze, int mazeSize, int* mazeColSize) {
    if (mazeSize == 0 || mazeColSize[0] == 0) {
        return -1;
    }

    int rows = mazeSize;
    int cols = mazeColSize[0];

    int start_r = -1, start_c = -1;
    int end_r = -1, end_c = -1;

    // Find start 'S' and end 'E'
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            if (maze[i][j] == 'S') {
                start_r = i;
                start_c = j;
            } else if (maze[i][j] == 'E') {
                end_r = i;
                end_c = j;
            }
        }
    }

    // If start or end not found, or if they are the same and we need 0 steps
    if (start_r == -1 || end_r == -1) {
        return -1;
    }
    if (start_r == end_r && start_c == end_c) {
        return 0;
    }

    // Initialize visited array
    bool* visited = (bool*)calloc(rows * cols, sizeof(bool));
    if (visited == NULL) {
        return -1; // Memory allocation failed
    }

    // Reset queue for each call (important if `shortestPath` is called multiple times)
    head = 0;
    tail = 0;

    // Enqueue the starting position
    enqueue(start_r, start_c, 0);
    visited[start_r * cols + start_c] = true;

    while (!is_empty()) {
        State current = dequeue();

        // Explore neighbors
        for (int i = 0; i < 4; ++i) {
            int new_r = current.r + dr[i];
            int new_c = current.c + dc[i];

            // Check bounds
            if (new_r >= 0 && new_r < rows && new_c >= 0 && new_c < cols) {
                // Check if not a wall and not visited
                if (maze[new_r][new_c] != '#' && !visited[new_r * cols + new_c]) {
                    if (new_r == end_r && new_c == end_c) {
                        free(visited);
                        return current.dist + 1;
                    }
                    visited[new_r * cols + new_c] = true;
                    enqueue(new_r, new_c, current.dist + 1);
                }
            }
        }
    }

    // If the queue becomes empty and the end was not reached
    free(visited);
    return -1;
}