#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* multiply(char* num1, char* num2) {
    int len1 = strlen(num1);
    int len2 = strlen(num2);
    char* result = (char*)calloc(len1 + len2 + 1, sizeof(char));
    int i, j, carry = 0;

    for (i = len1 - 1; i >= 0; i--) {
        carry = 0;
        for (j = len2 - 1; j >= 0; j--) {
            int product = (num1[i] - '0') * (num2[j] - '0') + carry;
            carry = product / 10;
            result[len1 + len2 - i - j - 1] += product % 10;
        }
        if (carry > 0) {
            result[len1 + len2 - i - 1] += carry;
        }
    }

    i = 0;
    while (i < len1 + len2 && result[i] == 0) {
        i++;
    }

    if (i == len1 + len2) {
        return "0";
    }

    for (j = 0; i < len1 + len2; i++, j++) {
        result[j] = result[i] + '0';
    }
    result[j] = '\0';

    return result;
}