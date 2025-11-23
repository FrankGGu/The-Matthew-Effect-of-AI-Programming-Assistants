#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int row;
    int col;
} Point;

typedef struct {
    Point *points;
    int size;
} PointList;

PointList* createPointList(int capacity) {
    PointList *list = (PointList*)malloc(sizeof(PointList));
    list->points = (Point*)malloc(capacity * sizeof(Point));
    list->size = 0;
    return list;
}

void addPoint(PointList *list, int row, int col) {
    list->points[list->size].row = row;
    list->points[list->size].col = col;
    list->size++;
}

void freePointList(PointList *list) {
    free(list->points);
    free(list);
}

int** pacificAtlantic(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    if (matrixSize == 0 || *matrixColSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int rows = matrixSize;
    int cols = *matrixColSize;

    bool **pacific = (bool**)malloc(rows * sizeof(bool*));
    bool **atlantic = (bool**)malloc(rows * sizeof(bool*));

    for (int i = 0; i < rows; i++) {
        pacific[i] = (bool*)calloc(cols, sizeof(bool));
        atlantic[i] = (bool*)calloc(cols, sizeof(bool));
    }

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    void bfs(bool **visited, int startRow, int startCol) {
        int queueSize = 0;
        Point *queue = (Point*)malloc(rows * cols * sizeof(Point));
        queue[queueSize].row = startRow;
        queue[queueSize].col = startCol;
        queueSize++;

        while (queueSize > 0) {
            Point current = queue[--queueSize];
            visited[current.row][current.col] = true;

            for (int d = 0; d < 4; d++) {
                int newRow = current.row + directions[d][0];
                int newCol = current.col + directions[d][1];

                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols &&
                    !visited[newRow][newCol] && matrix[newRow][newCol] >= matrix[current.row][current.col]) {
                    queue[queueSize].row = newRow;
                    queue[queueSize].col = newCol;
                    queueSize++;
                }
            }
        }
        free(queue);
    }

    for (int i = 0; i < rows; i++) {
        bfs(pacific, i, 0);
        bfs(atlantic, i, cols - 1);
    }

    for (int j = 0; j < cols; j++) {
        bfs(pacific, 0, j);
        bfs(atlantic, rows - 1, j);
    }

    int count = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (pacific[i][j] && atlantic[i][j]) {
                count++;
            }
        }
    }

    *returnSize = count;
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    int **result = (int**)malloc(count * sizeof(int*));

    int index = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (pacific[i][j] && atlantic[i][j]) {
                result[index] = (int*)malloc(2 * sizeof(int));
                result[index][0] = i;
                result[index][1] = j;
                (*returnColumnSizes)[index] = 2;
                index++;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(pacific[i]);
        free(atlantic[i]);
    }
    free(pacific);
    free(atlantic);

    return result;
}