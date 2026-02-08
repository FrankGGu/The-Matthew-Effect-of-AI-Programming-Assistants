#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canFormArray(int* arr, int arrSize, int** pieces, int piecesSize, int* piecesColSize) {
    int arrIndex = 0;
    while (arrIndex < arrSize) {
        bool found = false;
        for (int i = 0; i < piecesSize; i++) {
            if (pieces[i][0] == arr[arrIndex]) {
                found = true;
                for (int j = 0; j < piecesColSize[i]; j++) {
                    if (arrIndex >= arrSize || pieces[i][j] != arr[arrIndex]) {
                        return false;
                    }
                    arrIndex++;
                }
                break;
            }
        }
        if (!found) {
            return false;
        }
    }
    return true;
}