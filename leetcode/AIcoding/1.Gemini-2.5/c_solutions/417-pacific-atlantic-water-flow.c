#include <stdlib.h>
#include <stdbool.h>

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

void bfs(int m, int n, int** heights, bool** canReach, int** queue, int* head, int* tail) {
    while (*head < *tail) {
        int r = queue[*head][0];
        int c = queue[*head][1];
        (*head)++;

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n &&
                !canReach[nr][nc] && heights[nr][nc] >= heights[r][c]) {
                canReach[nr][nc] = true;
                queue[*tail][0] = nr;
                queue[*tail][1] = nc;
                (*tail)++;
            }
        }
    }
}

int** pacificAtlantic(int** heights, int heightsSize, int* heightsColSize, int* returnSize, int** returnColumnSizes) {
    int m = heightsSize;
    if (m == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }
    int n = heightsColSize[0];
    if (n == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    bool** canReachPacific = (bool**)malloc(m * sizeof(bool*));
    bool** canReachAtlantic = (bool**)malloc(m * sizeof(bool*));
    for (int i = 0; i < m; i++) {
        canReachPacific[i] = (bool*)calloc(n, sizeof(bool));
        canReachAtlantic[i] = (bool*)calloc(n, sizeof(bool));
    }

    int** queue = (int**)malloc(m * n * sizeof(int*));
    for (int i = 0; i < m * n; i++) {
        queue[i] = (int*)malloc(2 * sizeof(int));
    }

    int head = 0;
    int tail = 0;

    // Initialize queue for Pacific BFS
    for (int c = 0; c < n; c++) {
        if (!canReachPacific[0][c]) {
            canReachPacific[0][c] = true;
            queue[tail][0] = 0;
            queue[tail][1] = c;
            tail++;
        }
    }
    for (int r = 0; r < m; r++) {
        if (!canReachPacific[r][0]) {
            canReachPacific[r][0] = true;
            queue[tail][0] = r;
            queue[tail][1] = 0;
            tail++;
        }
    }
    bfs(m, n, heights, canReachPacific, queue, &head, &tail);

    // Reset queue for Atlantic BFS
    head = 0;
    tail = 0;
    for (int c = 0; c < n; c++) {
        if (!canReachAtlantic[m - 1][c]) {
            canReachAtlantic[m - 1][c] = true;
            queue[tail][0] = m - 1;
            queue[tail][1] = c;
            tail++;
        }
    }
    for (int r = 0; r < m; r++) {
        if (!canReachAtlantic[r][n - 1]) {
            canReachAtlantic[r][n - 1] = true;
            queue[tail][0] = r;
            queue[tail][1] = n - 1;
            tail++;
        }
    }
    bfs(m, n, heights, canReachAtlantic, queue, &head, &tail);

    int capacity = m * n;
    int** result = (int**)malloc(capacity * sizeof(int*));
    *returnColumnSizes = (int*)malloc(capacity * sizeof(int));
    *returnSize = 0;

    for (int r = 0; r < m; r++) {
        for (int c = 0; c < n; c++) {
            if (canReachPacific[r][c] && canReachAtlantic[r][c]) {
                result[*returnSize] = (int*)malloc(2 * sizeof(int));
                result[*returnSize][0] = r;
                result[*returnSize][1] = c;
                (*returnColumnSizes)[*returnSize] = 2;
                (*returnSize)++;
            }
        }
    }

    for (int i = 0; i < m; i++) {
        free(canReachPacific[i]);
        free(canReachAtlantic[i]);
    }
    free(canReachPacific);
    free(canReachAtlantic);

    for (int i = 0; i < m * n; i++) {
        free(queue[i]);
    }
    free(queue);

    return result;
}