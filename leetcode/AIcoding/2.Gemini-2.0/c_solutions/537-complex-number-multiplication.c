#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *complexNumberMultiply(char *num1, char *num2) {
    int real1, imag1, real2, imag2;
    sscanf(num1, "%d+%di", &real1, &imag1);
    sscanf(num2, "%d+%di", &real2, &imag2);

    int real_res = real1 * real2 - imag1 * imag2;
    int imag_res = real1 * imag2 + imag1 * real2;

    char *result = (char *)malloc(32 * sizeof(char));
    sprintf(result, "%d+%di", real_res, imag_res);

    return result;
}