#include <stdlib.h>

double* getCollisionTimes(int** cars, int carsSize, int* carsColSize, int* returnSize) {
    *returnSize = carsSize;
    double* result = (double*)malloc(carsSize * sizeof(double));
    if (result == NULL) {
        return NULL;
    }

    int* stack = (int*)malloc(carsSize * sizeof(int));
    if (stack == NULL) {
        free(result);
        return NULL;
    }
    int stackTop = -1;

    for (int i = carsSize - 1; i >= 0; --i) {
        result[i] = -1.0;

        while (stackTop != -1) {
            int j = stack[stackTop];

            if (cars[i][1] <= cars[j][1]) {
                stackTop--;
            } else {
                double t_ij = (double)(cars[j][0] - cars[i][0]) / (cars[i][1] - cars[j][1]);

                if (result[j] != -1.0 && t_ij >= result[j]) {
                    stackTop--;
                } else {
                    result[i] = t_ij;
                    break;
                }
            }
        }

        stackTop++;
        stack[stackTop] = i;
    }

    free(stack);
    return result;
}