#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int oddCells(int n, int m, int** indices, int indicesSize, int* indicesColSize){
    int matrix[n][m];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            matrix[i][j] = 0;
        }
    }

    for (int i = 0; i < indicesSize; i++) {
        int row = indices[i][0];
        int col = indices[i][1];

        for (int j = 0; j < m; j++) {
            matrix[row][j]++;
        }

        for (int j = 0; j < n; j++) {
            matrix[j][col]++;
        }
    }

    int odd_count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (matrix[i][j] % 2 != 0) {
                odd_count++;
            }
        }
    }

    return odd_count;
}