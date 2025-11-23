#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

int compare(const void *a, const void *b) {
    Point *p1 = (Point *)a;
    Point *p2 = (Point *)b;
    if (p1->x != p2->x) return p1->x - p2->x;
    return p1->y - p2->y;
}

int** getValidMoves(int** board, int boardSize, int* boardColSize, int* returnSize, int** returnColumnSizes) {
    int** result = NULL;
    *returnSize = 0;
    *returnColumnSizes = NULL;

    Point positions[boardSize * boardColSize[0]];
    int count = 0;

    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardColSize[i]; j++) {
            if (board[i][j] == 0) {
                positions[count++] = (Point){i, j};
            }
        }
    }

    qsort(positions, count, sizeof(Point), compare);

    *returnSize = count;
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    result = (int**)malloc(count * sizeof(int*));

    for (int i = 0; i < count; i++) {
        (*returnColumnSizes)[i] = 2;
        result[i] = (int*)malloc(2 * sizeof(int));
        result[i][0] = positions[i].x;
        result[i][1] = positions[i].y;
    }

    return result;
}