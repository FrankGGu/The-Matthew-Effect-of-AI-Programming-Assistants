#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** findFarmland(int** land, int landSize, int* landColSize, int* returnSize, int** returnColumnSizes){
    *returnSize = 0;
    *returnColumnSizes = (int*)malloc(sizeof(int) * landSize * *landColSize);
    int** result = (int**)malloc(sizeof(int*) * landSize * *landColSize);
    int r1, c1, r2, c2;
    for (int i = 0; i < landSize; i++) {
        for (int j = 0; j < *landColSize; j++) {
            if (land[i][j] == 1) {
                r1 = i;
                c1 = j;
                r2 = i;
                c2 = j;
                for (int k = i; k < landSize; k++) {
                    if (land[k][j] == 1) {
                        r2 = k;
                    } else {
                        break;
                    }
                }
                for (int l = j; l < *landColSize; l++) {
                    if (land[i][l] == 1) {
                        c2 = l;
                    } else {
                        break;
                    }
                }
                for (int row = i; row <= r2; row++) {
                    for (int col = j; col <= c2; col++) {
                        land[row][col] = 0;
                    }
                }
                result[*returnSize] = (int*)malloc(sizeof(int) * 4);
                result[*returnSize][0] = r1;
                result[*returnSize][1] = c1;
                result[*returnSize][2] = r2;
                result[*returnSize][3] = c2;
                (*returnColumnSizes)[*returnSize] = 4;
                (*returnSize)++;
            }
        }
    }
    return result;
}