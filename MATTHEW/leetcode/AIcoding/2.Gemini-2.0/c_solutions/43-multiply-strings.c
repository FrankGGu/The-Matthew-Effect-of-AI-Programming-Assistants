#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *multiply(char *num1, char *num2) {
    int len1 = strlen(num1);
    int len2 = strlen(num2);
    int len = len1 + len2;
    int *product = (int *)malloc(len * sizeof(int));
    memset(product, 0, len * sizeof(int));

    for (int i = len1 - 1; i >= 0; i--) {
        for (int j = len2 - 1; j >= 0; j--) {
            int digit1 = num1[i] - '0';
            int digit2 = num2[j] - '0';
            int p = digit1 * digit2;
            int p1 = i + j;
            int p2 = i + j + 1;
            int sum = p + product[p2];

            product[p2] = sum % 10;
            product[p1] += sum / 10;
        }
    }

    int i = 0;
    while (i < len - 1 && product[i] == 0) {
        i++;
    }

    char *result = (char *)malloc((len - i + 1) * sizeof(char));
    int k = 0;
    while (i < len) {
        result[k++] = product[i++] + '0';
    }
    result[k] = '\0';

    free(product);
    return result;
}