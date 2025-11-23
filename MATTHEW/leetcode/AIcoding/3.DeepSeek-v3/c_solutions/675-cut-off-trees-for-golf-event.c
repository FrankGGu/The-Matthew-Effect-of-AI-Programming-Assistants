#include <stdlib.h>
#include <string.h>

typedef struct {
    int x, y, steps;
} Node;

int dirs[4][2] = {{0,1}, {0,-1}, {1,0}, {-1,0}};

int bfs(int** forest, int forestSize, int* forestColSize, int sr, int sc, int tr, int tc) {
    if (sr == tr && sc == tc) return 0;

    int rows = forestSize, cols = forestColSize[0];
    int** visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)malloc(cols * sizeof(int));
        memset(visited[i], 0, cols * sizeof(int));
    }

    Node* queue = (Node*)malloc(rows * cols * sizeof(Node));
    int front = 0, rear = 0;
    queue[rear++] = (Node){sr, sc, 0};
    visited[sr][sc] = 1;

    while (front < rear) {
        Node cur = queue[front++];
        for (int i = 0; i < 4; i++) {
            int nx = cur.x + dirs[i][0];
            int ny = cur.y + dirs[i][1];
            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && forest[nx][ny] > 0 && !visited[nx][ny]) {
                if (nx == tr && ny == tc) {
                    for (int i = 0; i < rows; i++) free(visited[i]);
                    free(visited);
                    free(queue);
                    return cur.steps + 1;
                }
                visited[nx][ny] = 1;
                queue[rear++] = (Node){nx, ny, cur.steps + 1};
            }
        }
    }

    for (int i = 0; i < rows; i++) free(visited[i]);
    free(visited);
    free(queue);
    return -1;
}

int cmp(const void* a, const void* b) {
    int* aa = *(int**)a;
    int* bb = *(int**)b;
    return aa[2] - bb[2];
}

int cutOffTree(int** forest, int forestSize, int* forestColSize) {
    int rows = forestSize, cols = forestColSize[0];
    int** trees = (int**)malloc(rows * cols * sizeof(int*));
    int count = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (forest[i][j] > 1) {
                trees[count] = (int*)malloc(3 * sizeof(int));
                trees[count][0] = i;
                trees[count][1] = j;
                trees[count][2] = forest[i][j];
                count++;
            }
        }
    }

    qsort(trees, count, sizeof(int*), cmp);

    int res = 0;
    int sr = 0, sc = 0;

    for (int i = 0; i < count; i++) {
        int tr = trees[i][0], tc = trees[i][1];
        int steps = bfs(forest, forestSize, forestColSize, sr, sc, tr, tc);
        if (steps == -1) {
            for (int j = 0; j < count; j++) free(trees[j]);
            free(trees);
            return -1;
        }
        res += steps;
        sr = tr;
        sc = tc;
    }

    for (int i = 0; i < count; i++) free(trees[i]);
    free(trees);
    return res;
}