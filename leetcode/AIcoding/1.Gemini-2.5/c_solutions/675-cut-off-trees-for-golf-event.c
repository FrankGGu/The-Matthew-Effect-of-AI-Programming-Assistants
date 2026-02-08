#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct {
    int h;
    int r;
    int c;
} Tree;

int compareTrees(const void *a, const void *b) {
    return ((Tree *)a)->h - ((Tree *)b)->h;
}

typedef struct {
    int r;
    int c;
    int steps;
} BFSNode;

int bfs(int** forest, int forestSize, int* forestColSize, int start_r, int start_c, int end_r, int end_c) {
    if (start_r == end_r && start_c == end_c) {
        return 0;
    }

    int rows = forestSize;
    int cols = forestColSize[0];

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    bool** visited = (bool**)malloc(rows * sizeof(bool*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (bool*)malloc(cols * sizeof(bool));
        memset(visited[i], 0, cols * sizeof(bool));
    }

    BFSNode* queue = (BFSNode*)malloc(rows * cols * sizeof(BFSNode));
    int head = 0;
    int tail = 0;

    queue[tail++] = (BFSNode){.r = start_r, .c = start_c, .steps = 0};
    visited[start_r][start_c] = true;

    while (head < tail) {
        BFSNode current = queue[head++];

        for (int i = 0; i < 4; i++) {
            int nr = current.r + dr[i];
            int nc = current.c + dc[i];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && !visited[nr][nc] && forest[nr][nc] > 0) {
                if (nr == end_r && nc == end_c) {
                    for (int j = 0; j < rows; j++) {
                        free(visited[j]);
                    }
                    free(visited);
                    free(queue);
                    return current.steps + 1;
                }
                visited[nr][nc] = true;
                queue[tail++] = (BFSNode){.r = nr, .c = nc, .steps = current.steps + 1};
            }
        }
    }

    for (int j = 0; j < rows; j++) {
        free(visited[j]);
    }
    free(visited);
    free(queue);
    return -1;
}

int cutOffTree(int** forest, int forestSize, int* forestColSize) {
    if (forestSize == 0 || forestColSize[0] == 0) {
        return 0;
    }

    int rows = forestSize;
    int cols = forestColSize[0];

    Tree* trees = (Tree*)malloc(rows * cols * sizeof(Tree));
    int treeCount = 0;

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            if (forest[r][c] > 1) {
                trees[treeCount++] = (Tree){.h = forest[r][c], .r = r, .c = c};
            }
        }
    }

    qsort(trees, treeCount, sizeof(Tree), compareTrees);

    int totalSteps = 0;
    int current_r = 0;
    int current_c = 0;

    for (int i = 0; i < treeCount; i++) {
        int target_r = trees[i].r;
        int target_c = trees[i].c;

        int steps = bfs(forest, forestSize, forestColSize, current_r, current_c, target_r, target_c);

        if (steps == -1) {
            free(trees);
            return -1;
        }

        totalSteps += steps;
        current_r = target_r;
        current_c = target_c;
    }

    free(trees);
    return totalSteps;
}