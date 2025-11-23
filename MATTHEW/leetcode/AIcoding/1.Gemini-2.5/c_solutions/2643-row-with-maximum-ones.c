#include <stdlib.h>

int* rowAndMaximumOnes(int** mat, int matSize, int* matColSize) {
    int maxOnesCount = 0;
    int maxOnesRowIndex = 0;

    for (int i = 0; i < matSize; i++) {
        int currentOnesCount = 0;
        for (int j = 0; j < matColSize[i]; j++) {
            if (mat[i][j] == 1) {
                currentOnesCount++;
            }
        }

        if (currentOnesCount > maxOnesCount) {
            maxOnesCount = currentOnesCount;
            maxOnesRowIndex = i;
        }
    }

    int* result = (int*)malloc(sizeof(int) * 2);
    result[0] = maxOnesRowIndex;
    result[1] = maxOnesCount;

    return result;
}