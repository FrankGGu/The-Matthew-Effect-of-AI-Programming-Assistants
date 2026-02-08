#include <stdlib.h>
#include <stdbool.h>

#define INF 0x3f3f3f3f // A large enough integer for infinity

typedef struct {
    int r, c;
} Cell;

typedef struct {
    Cell* data;
    int front, rear, size, capacity;
} Queue;

void initQueue(Queue* q, int capacity) {
    q->data = (Cell*)malloc(sizeof(Cell) * capacity);
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    q->capacity = capacity;
}

bool isEmpty(Queue* q) {
    return q->size == 0;
}

void enqueue(Queue* q, int r, int c) {
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear].r = r;
    q->data[q->rear].c = c;
    q->size++;
}

Cell dequeue(Queue* q) {
    Cell cell = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return cell;
}

void freeQueue(Queue* q) {
    free(q->data);
}

int find_next_col(int r, int c_idx, int n, int** next_unvisited_col) {
    if (c_idx >= n) return n; // Out of bounds, return sentinel value

    if (next_unvisited_col[r][c_idx] == c_idx) {
        return c_idx; // c_idx is the root of its set (smallest unvisited column)
    }
    // Path compression: make c_idx point directly to the root
    return next_unvisited_col[r][c_idx] = find_next_col(r, next_unvisited_col[r][c_idx], n, next_unvisited_col);
}

int find_next_row(int c, int r_idx, int m, int** next_unvisited_row) {
    if (r_idx >= m) return m; // Out of bounds, return sentinel value

    if (next_unvisited_row[c][r_idx] == r_idx) {
        return r_idx; // r_idx is the root of its set (smallest unvisited row)
    }
    // Path compression: make r_idx point directly to the root
    return next_unvisited_row[c][r_idx] = find_next_row(c, next_unvisited_row[c][r_idx], m, next_unvisited_row);
}

int minimumVisitedCells(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    if (m == 1 && n == 1) {
        return 1; // Already at target
    }

    // dist[r][c] stores minimum steps to reach (r, c)
    int** dist = (int**)malloc(sizeof(int*) * m);
    for (int i = 0; i < m; ++i) {
        dist[i] = (int*)malloc(sizeof(int) * n);
        for (int j = 0; j < n; ++j) {
            dist[i][j] = INF; // Initialize all distances to infinity
        }
    }

    // next_unvisited_col[r][c_idx]: For row `r`, stores the smallest column `j >= c_idx` that is unvisited.
    // Size `n + 1` to include `n` as a sentinel for out-of-bounds.
    int** next_unvisited_col = (int**)malloc(sizeof(int*) * m);
    for (int i = 0; i < m; ++i) {
        next_unvisited_col[i] = (int*)malloc(sizeof(int) * (n + 1));
        for (int j = 0; j <= n; ++j) {
            next_unvisited_col[i][j] = j; // Initially, each index points to itself
        }
    }

    // next_unvisited_row[c][r_idx]: For column `c`, stores the smallest row `i >= r_idx` that is unvisited.
    // Size `m + 1` to include `m` as a sentinel for out-of-bounds.
    int** next_unvisited_row = (int**)malloc(sizeof(int*) * n);
    for (int j = 0; j < n; ++j) {
        next_unvisited_row[j] = (int*)malloc(sizeof(int) * (m + 1));
        for (int i = 0; i <= m; ++i) {
            next_unvisited_row[j][i] = i; // Initially, each index points to itself
        }
    }

    Queue q;
    initQueue(&q, m * n); // Queue capacity is max number of cells

    dist[0][0] = 1; // Starting cell (0,0) takes 1 step
    enqueue(&q, 0, 0);

    // Mark (0,0) as visited in the DSU structures
    // For row 0, column 0 is now visited. Its next unvisited is now whatever comes after 0.
    next_unvisited_col[0][0] = find_next_col(0, 1, n, next_unvisited_col);
    // For column 0, row 0 is now visited. Its next unvisited is now whatever comes after 0.
    next_unvisited_row[0][0] = find_next_row(0, 1, m, next_unvisited_row);

    while (!isEmpty(&q)) {
        Cell curr = dequeue(&q);
        int r = curr.r;
        int c = curr.c;
        int current_dist = dist[r][c];

        // If target (m-1, n-1) is reached, this is the minimum path
        if (r == m - 1 && c == n - 1) {
            // Free all allocated memory before returning
            for (int i = 0; i < m; ++i) {
                free(dist[i]);
                free(next_unvisited_col[i]);
            }
            free(dist);
            free(next_unvisited_col);
            for (int j = 0; j < n; ++j) {
                free(next_unvisited_row[j]);
            }
            free(next_unvisited_row);
            freeQueue(&q);
            return current_dist;
        }

        int max_jump = grid[r][c];

        // Process horizontal jumps from (r, c)
        // Start checking from the first unvisited column after `c`
        int next_c_to_check = find_next_col(r, c + 1, n, next_unvisited_col);
        while (next_c_to_check < n && next_c_to_check <= c + max_jump) {
            // If this cell (r, next_c_to_check) has not been visited yet
            if (dist[r][next_c_to_check] == INF) {
                dist[r][next_c_to_check] = current_dist + 1;
                enqueue(&q, r, next_c_to_check);
            }
            // Mark next_c_to_check as visited for row `r` in the DSU structure.
            // This means any future query for `find_next_col(r, next_c_to_check, ...)`
            // should now resolve to the next unvisited cell *after* next_c_to_check.
            next_unvisited_col[r][next_c_to_check] = find_next_col(r, next_c_to_check + 1, n, next_unvisited_col);
            // Move to the next unvisited column in the current range
            next_c_to_check = find_next_col(r, next_c_to_check, n, next_unvisited_col);
        }

        // Process vertical jumps from (r, c)
        // Start checking from the first unvisited row after `r`
        int next_r_to_check = find_next_row(c, r + 1, m, next_unvisited_row);
        while (next_r_to_check < m && next_r_to_check <= r + max_jump) {
            // If this cell (next_r_to_check, c) has not been visited yet
            if (dist[next_r_to_check][c] == INF) {
                dist[next_r_to_check][c] = current_dist + 1;
                enqueue(&q, next_r_to_check, c);
            }
            // Mark next_r_to_check as visited for column `c` in the DSU structure
            next_unvisited_row[c][next_r_to_check] = find_next_row(c, next_r_to_check + 1, m, next_unvisited_row);
            // Move to the next unvisited row in the current range
            next_r_to_check = find_next_row(c, next_r_to_check, m, next_unvisited_row);
        }
    }

    // If the loop finishes and target (m-1, n-1) was not reached
    int result = dist[m - 1][n - 1];
    if (result == INF) {
        result = -1; // Target is unreachable
    }

    // Free all allocated memory
    for (int i = 0; i < m; ++i) {
        free(dist[i]);
        free(next_unvisited_col[i]);
    }
    free(dist);
    free(next_unvisited_col);
    for (int j = 0; j < n; ++j) {
        free(next_unvisited_row[j]);
    }
    free(next_unvisited_row);
    freeQueue(&q);

    return result;
}