#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 100

typedef struct {
    int row;
    int col;
    int effort;
} Node;

int minEffortPath(int** heights, int heightsSize, int* heightsColSize){
    int rows = heightsSize;
    int cols = heightsColSize[0];

    int efforts[MAX_SIZE][MAX_SIZE];
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            efforts[i][j] = 1000001;
        }
    }
    efforts[0][0] = 0;

    bool visited[MAX_SIZE][MAX_SIZE];
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            visited[i][j] = false;
        }
    }

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    Node pq[rows * cols];
    int pqSize = 0;

    pq[pqSize].row = 0;
    pq[pqSize].col = 0;
    pq[pqSize].effort = 0;
    pqSize++;

    while (pqSize > 0) {
        int minIndex = 0;
        for (int i = 1; i < pqSize; i++) {
            if (pq[i].effort < pq[minIndex].effort) {
                minIndex = i;
            }
        }

        Node current = pq[minIndex];
        pq[minIndex] = pq[pqSize - 1];
        pqSize--;

        int r = current.row;
        int c = current.col;
        int effort = current.effort;

        if (visited[r][c]) continue;
        visited[r][c] = true;

        if (r == rows - 1 && c == cols - 1) {
            return effort;
        }

        for (int i = 0; i < 4; i++) {
            int nr = r + dx[i];
            int nc = c + dy[i];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
                int newEffort = abs(heights[r][c] - heights[nr][nc]);
                newEffort = (effort > newEffort) ? effort : newEffort;

                if (newEffort < efforts[nr][nc]) {
                    efforts[nr][nc] = newEffort;
                    pq[pqSize].row = nr;
                    pq[pqSize].col = nc;
                    pq[pqSize].effort = newEffort;
                    pqSize++;
                }
            }
        }
    }

    return efforts[rows - 1][cols - 1];
}