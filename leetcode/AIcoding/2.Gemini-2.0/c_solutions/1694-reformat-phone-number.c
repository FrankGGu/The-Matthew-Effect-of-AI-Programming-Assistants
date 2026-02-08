#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * reformatNumber(char * number){
    int len = strlen(number);
    char *digits = (char *)malloc(sizeof(char) * (len + 1));
    int digits_len = 0;

    for (int i = 0; i < len; i++) {
        if (number[i] >= '0' && number[i] <= '9') {
            digits[digits_len++] = number[i];
        }
    }
    digits[digits_len] = '\0';

    int result_len = digits_len + (digits_len - 1) / 3;
    char *result = (char *)malloc(sizeof(char) * (result_len + 1));
    int result_index = 0;
    int digits_index = 0;

    while (digits_len > 4) {
        result[result_index++] = digits[digits_index++];
        result[result_index++] = digits[digits_index++];
        result[result_index++] = digits[digits_index++];
        result[result_index++] = '-';
        digits_len -= 3;
    }

    if (digits_len == 4) {
        result[result_index++] = digits[digits_index++];
        result[result_index++] = digits[digits_index++];
        result[result_index++] = '-';
        result[result_index++] = digits[digits_index++];
        result[result_index++] = digits[digits_index++];
    } else if (digits_len == 3) {
        result[result_index++] = digits[digits_index++];
        result[result_index++] = digits[digits_index++];
        result[result_index++] = digits[digits_index++];
    } else if (digits_len == 2) {
        result[result_index++] = digits[digits_index++];
        result[result_index++] = digits[digits_index++];
    }

    result[result_index] = '\0';
    free(digits);
    return result;
}