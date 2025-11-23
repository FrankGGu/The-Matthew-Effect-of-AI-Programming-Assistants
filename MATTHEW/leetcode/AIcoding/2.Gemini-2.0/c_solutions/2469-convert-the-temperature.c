#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double* convertTemperature(double celsius, int* returnSize){
    double* result = (double*)malloc(2 * sizeof(double));
    result[0] = celsius + 273.15;
    result[1] = celsius * 1.80 + 32.00;
    *returnSize = 2;
    return result;
}