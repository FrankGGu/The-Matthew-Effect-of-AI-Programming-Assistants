#include <stdio.h>
#include <stdlib.h>

double* convertTemperature(double celsius, int* returnSize) {
    double* result = (double*)malloc(2 * sizeof(double));
    result[0] = celsius + 273.15;
    result[1] = celsius * 9.0 / 5.0 + 32.0;
    *returnSize = 2;
    return result;
}