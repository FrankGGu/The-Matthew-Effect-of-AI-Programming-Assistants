#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** generateParenthesis(int n, int* returnSize){
    char **result = (char**)malloc(sizeof(char*) * 10000);
    *returnSize = 0;
    char *str = (char*)malloc(sizeof(char) * (2 * n + 1));
    str[2 * n] = '\0';

    void generate(int open, int close, int index) {
        if (open == 0 && close == 0) {
            result[*returnSize] = (char*)malloc(sizeof(char) * (2 * n + 1));
            strcpy(result[*returnSize], str);
            (*returnSize)++;
            return;
        }

        if (open > 0) {
            str[index] = '(';
            generate(open - 1, close, index + 1);
        }

        if (close > open) {
            str[index] = ')';
            generate(open, close - 1, index + 1);
        }
    }

    generate(n, n, 0);
    free(str);
    return result;
}