#include <string.h>
#include <stdlib.h>
#include <stdio.h>

char *addStrings(char *num1, char *num2) {
    int len1 = strlen(num1);
    int len2 = strlen(num2);
    int maxLen = (len1 > len2 ? len1 : len2);
    char *result = (char *)malloc(sizeof(char) * (maxLen + 2)); // +1 for carry, +1 for null terminator
    if (result == NULL) {
        return NULL; // Handle malloc failure
    }
    result[maxLen + 1] = '\0';

    int i = len1 - 1;
    int j = len2 - 1;
    int k = maxLen;
    int carry = 0;

    while (i >= 0 || j >= 0 || carry > 0) {
        int digit1 = (i >= 0) ? (num1[i--] - '0') : 0;
        int digit2 = (j >= 0) ? (num2[j--] - '0') : 0;

        int sum = digit1 + digit2 + carry;
        carry = sum / 10;
        result[k--] = (sum % 10) + '0';
    }

    if (k == -1) { // This means there was a carry that needed an extra character at the beginning
        return result;
    } else { // This means the result buffer was larger than needed, shift and return substring
        return result + k + 1;
    }
}