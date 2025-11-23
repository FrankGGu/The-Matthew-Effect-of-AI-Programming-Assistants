#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef int (*CustomFunction)(int, int);

int** findSolution(CustomFunction customfunction, int z, int* returnSize, int** returnColumnSizes){
    int** result = (int**)malloc(sizeof(int*) * 1000);
    *returnColumnSizes = (int*)malloc(sizeof(int) * 1000);
    *returnSize = 0;

    for (int x = 1; x <= 1000; x++) {
        for (int y = 1; y <= 1000; y++) {
            int val = customfunction(x, y);
            if (val == z) {
                result[*returnSize] = (int*)malloc(sizeof(int) * 2);
                result[*returnSize][0] = x;
                result[*returnSize][1] = y;
                (*returnColumnSizes)[*returnSize] = 2;
                (*returnSize)++;
            } else if (val > z) {
                break;
            }
        }
    }

    return result;
}