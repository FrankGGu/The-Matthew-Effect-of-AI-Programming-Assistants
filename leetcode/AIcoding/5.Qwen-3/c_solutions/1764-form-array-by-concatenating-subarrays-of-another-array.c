#include <stdio.h>
#include <stdlib.h>

bool canFormArray(int** arrs, int arrsSize, int* arrsColSizes, int* arr, int arrSize) {
    int* indexMap = (int*)malloc(arrsSize * sizeof(int));
    for (int i = 0; i < arrsSize; i++) {
        indexMap[i] = -1;
    }

    for (int i = 0; i < arrsSize; i++) {
        int* sub = arrs[i];
        int subSize = arrsColSizes[i];
        for (int j = 0; j <= arrSize - subSize; j++) {
            int match = 1;
            for (int k = 0; k < subSize; k++) {
                if (arr[j + k] != sub[k]) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                indexMap[i] = j;
                break;
            }
        }
        if (indexMap[i] == -1) {
            free(indexMap);
            return false;
        }
    }

    for (int i = 0; i < arrsSize; i++) {
        for (int j = i + 1; j < arrsSize; j++) {
            if (indexMap[i] > indexMap[j]) {
                int temp = indexMap[i];
                indexMap[i] = indexMap[j];
                indexMap[j] = temp;
            }
        }
    }

    int pos = 0;
    for (int i = 0; i < arrsSize; i++) {
        int subSize = arrsColSizes[i];
        int start = indexMap[i];
        for (int j = 0; j < subSize; j++) {
            if (pos >= arrSize || arr[pos++] != arrs[i][j]) {
                free(indexMap);
                return false;
            }
        }
    }

    free(indexMap);
    return true;
}