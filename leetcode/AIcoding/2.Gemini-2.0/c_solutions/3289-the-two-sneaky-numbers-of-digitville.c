#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* theTwoSneakyNumbers(int n) {
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = n / 2;
    result[1] = n - result[0];
    return result;
}