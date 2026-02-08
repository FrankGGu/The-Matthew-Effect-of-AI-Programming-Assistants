#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** allCellsDistOrder(int rows, int cols, int rCenter, int cCenter, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * rows * cols);
    *returnColumnSizes = (int*)malloc(sizeof(int) * rows * cols);
    *returnSize = rows * cols;

    for (int i = 0; i < rows * cols; i++) {
        result[i] = (int*)malloc(sizeof(int) * 2);
        (*returnColumnSizes)[i] = 2;
    }

    int index = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            result[index][0] = i;
            result[index][1] = j;
            index++;
        }
    }

    qsort(result, rows * cols, sizeof(int*),
          (int (*)(const void *, const void *))
          (
              [&](const void* a, const void* b) -> int {
                  int* cell1 = *(int**)a;
                  int* cell2 = *(int**)b;
                  int dist1 = abs(cell1[0] - rCenter) + abs(cell1[1] - cCenter);
                  int dist2 = abs(cell2[0] - rCenter) + abs(cell2[1] - cCenter);
                  return dist1 - dist2;
              }
          )
    );

    return result;
}