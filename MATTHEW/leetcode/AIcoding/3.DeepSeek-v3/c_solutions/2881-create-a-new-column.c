#include <stdlib.h>

char** createNewColumn(char*** data, int dataSize, int* dataColSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = dataSize;
    *returnColumnSizes = malloc(dataSize * sizeof(int));
    char** result = malloc(dataSize * sizeof(char*));

    for (int i = 0; i < dataSize; i++) {
        (*returnColumnSizes)[i] = dataColSize[i] + 1;
        result[i] = malloc(20 * sizeof(char));
        int sum = 0;
        for (int j = 1; j < dataColSize[i]; j++) {
            sum += atoi(data[i][j]);
        }
        sprintf(result[i], "%d", sum);
    }

    return result;
}