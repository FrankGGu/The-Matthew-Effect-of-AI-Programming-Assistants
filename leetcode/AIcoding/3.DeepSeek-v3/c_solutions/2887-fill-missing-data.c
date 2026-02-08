#include <stdio.h>
#include <stdlib.h>

char** fillMissingData(char*** products, int productsSize, int* productsColSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = productsSize;
    *returnColumnSizes = (int*)malloc(productsSize * sizeof(int));
    char*** result = (char***)malloc(productsSize * sizeof(char**));

    for (int i = 0; i < productsSize; i++) {
        (*returnColumnSizes)[i] = productsColSize[i];
        result[i] = (char**)malloc(productsColSize[i] * sizeof(char*));

        for (int j = 0; j < productsColSize[i]; j++) {
            if (products[i][j] == NULL || strcmp(products[i][j], "") == 0) {
                result[i][j] = (char*)malloc(5 * sizeof(char));
                strcpy(result[i][j], "None");
            } else {
                result[i][j] = (char*)malloc((strlen(products[i][j]) + 1) * sizeof(char));
                strcpy(result[i][j], products[i][j]);
            }
        }
    }

    return result;
}