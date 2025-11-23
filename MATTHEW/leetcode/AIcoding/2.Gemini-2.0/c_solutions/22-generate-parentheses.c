#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** generateParenthesis(int n, int* returnSize){
    char **result = NULL;
    int capacity = 0;
    *returnSize = 0;

    void backtrack(char *str, int open, int close, int max) {
        if (strlen(str) == 2 * max) {
            if (*returnSize == capacity) {
                capacity = capacity == 0 ? 1 : capacity * 2;
                result = (char **)realloc(result, capacity * sizeof(char *));
            }
            result[*returnSize] = (char *)malloc((2 * max + 1) * sizeof(char));
            strcpy(result[*returnSize], str);
            (*returnSize)++;
            return;
        }

        if (open < max) {
            char *new_str = (char *)malloc((strlen(str) + 2) * sizeof(char));
            strcpy(new_str, str);
            strcat(new_str, "(");
            backtrack(new_str, open + 1, close, max);
            free(new_str);
        }
        if (close < open) {
            char *new_str = (char *)malloc((strlen(str) + 2) * sizeof(char));
            strcpy(new_str, str);
            strcat(new_str, ")");
            backtrack(new_str, open, close + 1, max);
            free(new_str);
        }
    }

    char *str = (char *)malloc(1 * sizeof(char));
    str[0] = '\0';
    backtrack(str, 0, 0, n);
    free(str);

    return result;
}