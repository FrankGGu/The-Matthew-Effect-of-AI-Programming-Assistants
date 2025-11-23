#include <stdlib.h>

int* findDiagonalOrder(int** mat, int matSize, int* matColSize, int* returnSize) {
    if (matSize == 0 || matColSize == NULL || matColSize[0] == 0) {
        *returnSize = 0;
        return NULL;
    }

    int m = matSize;
    int n = matColSize[0];
    int totalElements = m * n;

    int* result = (int*)malloc(totalElements * sizeof(int));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int r = 0; // current row
    int c = 0; // current column
    int direction = 1; // 1 for up-right, -1 for down-left

    for (int i = 0; i < totalElements; i++) {
        result[i] = mat[r][c];

        if (i == totalElements - 1) {
            break; 
        }

        if (direction == 1) { // Moving up-right
            int next_r = r - 1;
            int next_c = c + 1;

            if (next_c == n) { // Hit right wall
                r++; 
                direction = -1; 
            } else if (next_r < 0) { // Hit top wall
                c++; 
                direction = -1; 
            } else { // Still within bounds, continue up-right
                r = next_r;
                c = next_c;
            }
        } else { // Moving down-left
            int next_r = r + 1;
            int next_c = c - 1;

            if (next_r == m) { // Hit bottom wall
                c++; 
                direction = 1; 
            } else if (next_c < 0) { // Hit left wall
                r++; 
                direction = 1; 
            } else { // Still within bounds, continue down-left
                r = next_r;
                c = next_c;
            }
        }
    }

    *returnSize = totalElements;
    return result;
}