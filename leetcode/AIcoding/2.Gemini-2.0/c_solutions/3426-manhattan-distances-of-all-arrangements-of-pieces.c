#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* solve(int n, int** pieces, int piecesSize, int* piecesColSize, int** positions, int positionsSize, int* positionsColSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * positionsSize);
    *returnSize = positionsSize;

    for (int i = 0; i < positionsSize; i++) {
        result[i] = 0;
    }

    int* x_coords = (int*)malloc(sizeof(int) * piecesSize);
    int* y_coords = (int*)malloc(sizeof(int) * piecesSize);

    for (int i = 0; i < piecesSize; i++) {
        x_coords[i] = pieces[i][0];
        y_coords[i] = pieces[i][1];
    }

    qsort(x_coords, piecesSize, sizeof(int), compare);
    qsort(y_coords, piecesSize, sizeof(int), compare);

    int* prefix_x = (int*)malloc(sizeof(int) * (piecesSize + 1));
    int* prefix_y = (int*)malloc(sizeof(int) * (piecesSize + 1));

    prefix_x[0] = 0;
    prefix_y[0] = 0;

    for (int i = 0; i < piecesSize; i++) {
        prefix_x[i + 1] = prefix_x[i] + x_coords[i];
        prefix_y[i + 1] = prefix_y[i] + y_coords[i];
    }

    for (int i = 0; i < positionsSize; i++) {
        int px = positions[i][0];
        int py = positions[i][1];

        int* x_ptr = bsearch(&px, x_coords, piecesSize, sizeof(int), compare);
        int x_index = (x_ptr == NULL) ? 0 : (x_ptr - x_coords);
        while(x_index > 0 && x_coords[x_index - 1] == px)
            x_index--;

        result[i] += px * (x_index) - prefix_x[x_index];
        result[i] += (prefix_x[piecesSize] - prefix_x[x_index]) - px * (piecesSize - x_index);

        int* y_ptr = bsearch(&py, y_coords, piecesSize, sizeof(int), compare);
        int y_index = (y_ptr == NULL) ? 0 : (y_ptr - y_coords);
        while(y_index > 0 && y_coords[y_index - 1] == py)
            y_index--;

        result[i] += py * (y_index) - prefix_y[y_index];
        result[i] += (prefix_y[piecesSize] - prefix_y[y_index]) - py * (piecesSize - y_index);
    }

    free(x_coords);
    free(y_coords);
    free(prefix_x);
    free(prefix_y);

    return result;
}