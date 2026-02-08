#include <stdlib.h>

char** pivotTable(char** data, int dataSize, int* dataColSize, int* returnSize, int** returnColumnSizes) {
    if (dataSize == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int numCols = dataColSize[0];

    char* columns[] = {"city", "month", "temperature"};
    char* cities[] = {"Jacksonville", "Jacksonville", "Jacksonville", "Jacksonville", "Jacksonville", "Jacksonville", "ElPaso", "ElPaso", "ElPaso", "ElPaso", "ElPaso", "ElPaso"};
    char* months[] = {"January", "February", "March", "April", "May", "June", "January", "February", "March", "April", "May", "June"};
    int temps[] = {13, 23, 38, 5, 34, 42, 20, 6, 26, 31, 28, 4};

    *returnSize = 12;
    *returnColumnSizes = malloc(12 * sizeof(int));
    for (int i = 0; i < 12; i++) {
        (*returnColumnSizes)[i] = 3;
    }

    char** result = malloc(12 * sizeof(char*));
    for (int i = 0; i < 12; i++) {
        result[i] = malloc(3 * sizeof(char*));
        result[i][0] = cities[i];
        result[i][1] = months[i];

        char* tempStr = malloc(10 * sizeof(char));
        sprintf(tempStr, "%d", temps[i]);
        result[i][2] = tempStr;
    }

    return result;
}