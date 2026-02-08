#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int digArtifacts(int n, int** artifacts, int artifactsSize, int* artifactsColSize, int** dig, int digSize, int* digColSize) {
    bool** dug = (bool**)malloc(n * sizeof(bool*));
    for (int i = 0; i < n; i++) {
        dug[i] = (bool*)malloc(n * sizeof(bool));
        for (int j = 0; j < n; j++) {
            dug[i][j] = false;
        }
    }

    for (int i = 0; i < digSize; i++) {
        dug[dig[i][0]][dig[i][1]] = true;
    }

    int count = 0;
    for (int i = 0; i < artifactsSize; i++) {
        bool canExtract = true;
        for (int row = artifacts[i][0]; row <= artifacts[i][2]; row++) {
            for (int col = artifacts[i][1]; col <= artifacts[i][3]; col++) {
                if (!dug[row][col]) {
                    canExtract = false;
                    break;
                }
            }
            if (!canExtract) break;
        }
        if (canExtract) count++;
    }

    for (int i = 0; i < n; i++) {
        free(dug[i]);
    }
    free(dug);

    return count;
}