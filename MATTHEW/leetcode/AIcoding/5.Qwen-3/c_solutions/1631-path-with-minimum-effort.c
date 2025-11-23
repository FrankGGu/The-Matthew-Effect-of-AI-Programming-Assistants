#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int row;
    int col;
    int effort;
} Node;

int compare(const void *a, const void *b) {
    return ((Node *)a)->effort - ((Node *)b)->effort;
}

int minimumEffortPath(int** heights, int heightsSize, int* heightsColSize) {
    int rows = heightsSize;
    int cols = heightsColSize[0];

    int** efforts = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        efforts[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            efforts[i][j] = INT_MAX;
        }
    }

    Node* pq = (Node*)malloc(rows * cols * sizeof(Node));
    int pqSize = 0;

    pq[pqSize].row = 0;
    pq[pqSize].col = 0;
    pq[pqSize].effort = 0;
    pqSize++;

    int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    while (pqSize > 0) {
        qsort(pq, pqSize, sizeof(Node), compare);
        Node current = pq[0];
        pqSize--;

        if (current.row == rows - 1 && current.col == cols - 1) {
            free(pq);
            for (int i = 0; i < rows; i++) {
                free(efforts[i]);
            }
            free(efforts);
            return current.effort;
        }

        if (current.effort > efforts[current.row][current.col]) {
            continue;
        }

        for (int d = 0; d < 4; d++) {
            int newRow = current.row + dirs[d][0];
            int newCol = current.col + dirs[d][1];

            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols) {
                int newEffort = current.effort + abs(heights[newRow][newCol] - heights[current.row][current.col]);

                if (newEffort < efforts[newRow][newCol]) {
                    efforts[newRow][newCol] = newEffort;
                    pq[pqSize].row = newRow;
                    pq[pqSize].col = newCol;
                    pq[pqSize].effort = newEffort;
                    pqSize++;
                }
            }
        }
    }

    free(pq);
    for (int i = 0; i < rows; i++) {
        free(efforts[i]);
    }
    free(efforts);

    return 0;
}