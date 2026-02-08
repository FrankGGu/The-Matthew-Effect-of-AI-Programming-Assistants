#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubmatrices(int** mat, int matSize, int* matColSize){
    int n = matSize;
    int m = matColSize[0];
    int count = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (mat[i][j] == 1) {
                int minWidth = m - j;
                for (int k = i; k < n; k++) {
                    int width = 0;
                    for (int l = j; l < m; l++) {
                        if (mat[k][l] == 1) {
                            width++;
                        } else {
                            break;
                        }
                    }
                    minWidth = (width < minWidth) ? width : minWidth;
                    count += minWidth;
                    if (minWidth == 0) break;
                }
            }
        }
    }
    return count;
}