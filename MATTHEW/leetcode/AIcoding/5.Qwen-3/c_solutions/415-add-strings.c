#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* addStrings(char* num1, char* num2) {
    int i = strlen(num1) - 1;
    int j = strlen(num2) - 1;
    int carry = 0;
    int len = (i > j ? i : j) + 2;
    char* result = (char*)malloc(len * sizeof(char));
    int k = 0;

    while (i >= 0 || j >= 0 || carry > 0) {
        int digit1 = (i >= 0) ? (num1[i] - '0') : 0;
        int digit2 = (j >= 0) ? (num2[j] - '0') : 0;
        int sum = digit1 + digit2 + carry;
        carry = sum / 10;
        result[k++] = (sum % 10) + '0';
        i--;
        j--;
    }

    result[k] = '\0';
    int start = 0;
    int end = k - 1;

    while (start < end) {
        char temp = result[start];
        result[start] = result[end];
        result[end] = temp;
        start++;
        end--;
    }

    return result;
}