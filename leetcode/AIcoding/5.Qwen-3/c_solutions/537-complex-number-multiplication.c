#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* complexNumberMultiply(char* a, char* b) {
    int real1, imag1, real2, imag2;
    sscanf(a, "%d+%di", &real1, &imag1);
    sscanf(b, "%d+%di", &real2, &imag2);

    int real = real1 * real2 - imag1 * imag2;
    int imag = real1 * imag2 + imag1 * real2;

    char* result = (char*)malloc(20 * sizeof(char));
    sprintf(result, "%d+%di", real, imag);
    return result;
}