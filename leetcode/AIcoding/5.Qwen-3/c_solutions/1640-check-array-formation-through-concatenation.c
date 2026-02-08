#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canFormArray(int* arr, int arrSize, int** pieces, int piecesSize, int* piecesColSize) {
    int* indexMap = (int*)malloc(101 * sizeof(int));
    for (int i = 0; i < 101; i++) {
        indexMap[i] = -1;
    }

    for (int i = 0; i < piecesSize; i++) {
        int first = pieces[i][0];
        indexMap[first] = i;
    }

    int i = 0;
    while (i < arrSize) {
        int key = arr[i];
        if (indexMap[key] == -1) {
            free(indexMap);
            return false;
        }
        int idx = indexMap[key];
        int len = piecesColSize[idx];
        for (int j = 0; j < len; j++) {
            if (i >= arrSize || arr[i] != pieces[idx][j]) {
                free(indexMap);
                return false;
            }
            i++;
        }
    }

    free(indexMap);
    return true;
}