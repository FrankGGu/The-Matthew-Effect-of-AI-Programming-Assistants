#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** letterCombinations(char* digits, int* returnSize) {
    int len = strlen(digits);
    if (len == 0) {
        *returnSize = 0;
        return NULL;
    }

    char* mapping[] = {"", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};

    int size = 1;
    for (int i = 0; i < len; i++) {
        int digit = digits[i] - '0';
        size *= strlen(mapping[digit]);
    }

    char** result = (char**)malloc(size * sizeof(char*));
    for (int i = 0; i < size; i++) {
        result[i] = (char*)malloc((len + 1) * sizeof(char));
        result[i][len] = '\0';
    }

    int count = 0;
    int repeat = size;
    for (int i = 0; i < len; i++) {
        int digit = digits[i] - '0';
        repeat /= strlen(mapping[digit]);
        for (int j = 0; j < size; j++) {
            result[j][i] = mapping[digit][(j / repeat) % strlen(mapping[digit])];
        }
    }

    *returnSize = size;
    return result;
}