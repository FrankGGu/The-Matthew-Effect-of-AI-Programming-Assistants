#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

typedef struct {
    int r, c;
} Point;

typedef struct {
    Point* data;
    int front, rear, size, capacity;
} Queue;

void initQueue(Queue* q, int capacity) {
    q->data = (Point*)malloc(capacity * sizeof(Point));
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    q->capacity = capacity;
}

void freeQueue(Queue* q) {
    free(q->data);
    q->data = NULL; // Prevent double free issues
}

void enqueue(Queue* q, Point p) {
    if (q->size == q->capacity) return; // Should not happen with sufficient capacity
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = p;
    q->size++;
}

Point dequeue(Queue* q) {
    Point p = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return p;
}

bool isEmpty(Queue* q) {
    return q->size == 0;
}

int** calculateDistances(int** grid, int n) {
    int** dist = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dist[i][j] = n * n; // Initialize with a large value (effectively infinity)
        }
    }

    Queue q;
    initQueue(&q, n * n);

    // Add all thief locations to the queue and set their distance to 0
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) { // Thief found
                dist[i][j] = 0;
                enqueue(&q, (Point){i, j});
            }
        }
    }

    // Perform multi-source BFS to fill the dist array
    while (!isEmpty(&q)) {
        Point curr = dequeue(&q);

        for (int i = 0; i < 4; i++) {
            int nr = curr.r + dr[i];
            int nc = curr.c + dc[i];

            // Check if neighbor is valid and unvisited (or has a longer path from a thief)
            if (nr >= 0 && nr < n && nc >= 0 && nc < n && dist[nr][nc] == n * n) { // dist[nr][nc] == n*n means unvisited
                dist[nr][nc] = dist[curr.r][curr.c] + 1;
                enqueue(&q, (Point){nr, nc});
            }
        }
    }
    freeQueue(&q);
    return dist;
}

bool canReach(int** dist, int n, int k) {
    // If the starting cell itself doesn't meet the safeness factor, no path exists
    if (dist[0][0] < k) {
        return false;
    }

    bool** visited = (bool**)malloc(n * sizeof(bool*));
    for (int i = 0; i < n; i++) {
        visited[i] = (bool*)malloc(n * sizeof(bool));
        memset(visited[i], 0, n * sizeof(bool)); // Initialize to false
    }

    Queue q;
    initQueue(&q, n * n);

    enqueue(&q, (Point){0, 0});
    visited[0][0] = true;

    while (!isEmpty(&q)) {
        Point curr = dequeue(&q);

        // If destination reached, a path exists
        if (curr.r == n - 1 && curr.c == n - 1) {
            freeQueue(&q);
            for (int i = 0; i < n; i++) {
                free(visited[i]);
            }
            free(visited);
            return true;
        }

        for (int i = 0; i < 4; i++) {
            int nr = curr.r + dr[i];
            int nc = curr.c + dc[i];

            // Check if neighbor is valid, unvisited, and meets the safeness factor 'k'
            if (nr >= 0 && nr < n && nc >= 0 && nc < n && !visited[nr][nc] && dist[nr][nc] >= k) {
                visited[nr][nc] = true;
                enqueue(&q, (Point){nr, nc});
            }
        }
    }

    // If loop finishes and destination not reached
    freeQueue(&q);
    for (int i = 0; i < n; i++) {
        free(visited[i]);
    }
    free(visited);
    return false;
}

int maximumSafenessFactor(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;

    // Step 1: Precompute minimum distances to thieves for all cells
    int** dist = calculateDistances(grid, n);

    // Step 2: Binary search on the safeness factor (the answer)
    int low = 0;
    int high = 2 * (n - 1); // Maximum possible Manhattan distance in an n x n grid
    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (canReach(dist, n, mid)) {
            ans = mid;      // mid is a possible safeness factor, try for a higher one
            low = mid + 1;
        } else {
            high = mid - 1; // mid is too high, try for a lower one
        }
    }

    // Free allocated memory for the distance grid
    for (int i = 0; i < n; i++) {
        free(dist[i]);
    }
    free(dist);

    return ans;
}