#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double* getCollisionTimes(int** cars, int carsSize, int* carsColSize, int* returnSize) {
    double* result = (double*)malloc(carsSize * sizeof(double));
    for (int i = 0; i < carsSize; i++) {
        result[i] = -1.0;
    }

    int* stack = (int*)malloc(carsSize * sizeof(int));
    int top = -1;

    for (int i = carsSize - 1; i >= 0; i--) {
        while (top >= 0) {
            int j = stack[top];
            if (cars[i][1] <= cars[j][1]) {
                top--;
            } else {
                double time = (double)(cars[j][0] - cars[i][0]) / (cars[i][1] - cars[j][1]);
                if (time <= result[j] || result[j] == -1.0) {
                    result[i] = time;
                    break;
                } else {
                    top--;
                }
            }
        }
        stack[++top] = i;
    }

    free(stack);
    *returnSize = carsSize;
    return result;
}