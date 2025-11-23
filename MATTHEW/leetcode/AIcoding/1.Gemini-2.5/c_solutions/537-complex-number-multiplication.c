#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *complexNumberMultiply(char *num1, char *num2) {
    int real1, imag1;
    int real2, imag2;

    sscanf(num1, "%d%di", &real1, &imag1);
    sscanf(num2, "%d%di", &real2, &imag2);

    int result_real = real1 * real2 - imag1 * imag2;
    int result_imag = real1 * imag2 + imag1 * real2;

    char *result_str = (char *)malloc(sizeof(char) * 20); // Max length: "-20000+-20000i" is 14 chars + null
    sprintf(result_str, "%d+%di", result_real, result_imag);

    return result_str;
}