#include <stdio.h>
#include <stdlib.h>

int** findSolution(int (*customFunction)(int, int), int z, int** returnSize, int** returnColumnSizes) {
    int** result = NULL;
    int count = 0;
    int x = 1;
    int y = 1000;

    while (x <= 1000 && y >= 1) {
        int val = customFunction(x, y);
        if (val == z) {
            result = realloc(result, sizeof(int*) * (count + 1));
            result[count] = malloc(sizeof(int) * 2);
            result[count][0] = x;
            result[count][1] = y;
            count++;
            x++;
            y--;
        } else if (val < z) {
            x++;
        } else {
            y--;
        }
    }

    *returnSize = count;
    *returnColumnSizes = malloc(sizeof(int) * count);
    for (int i = 0; i < count; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    return result;
}