#include <stdlib.h>
#include <string.h>

void backtrack(char** result, int* returnSize, char* current_string, int open_count, int close_count, int max_n, int current_pos) {
    if (current_pos == 2 * max_n) {
        current_string[current_pos] = '\0';
        result[*returnSize] = (char*)malloc(sizeof(char) * (2 * max_n + 1));
        strcpy(result[*returnSize], current_string);
        (*returnSize)++;
        return;
    }

    if (open_count < max_n) {
        current_string[current_pos] = '(';
        backtrack(result, returnSize, current_string, open_count + 1, close_count, max_n, current_pos + 1);
    }

    if (close_count < open_count) {
        current_string[current_pos] = ')';
        backtrack(result, returnSize, current_string, open_count, close_count + 1, max_n, current_pos + 1);
    }
}

char ** generateParenthesis(int n, int* returnSize) {
    char **result = (char**)malloc(sizeof(char*) * 10000); 
    *returnSize = 0;

    char* current_string = (char*)malloc(sizeof(char) * (2 * n + 1));

    backtrack(result, returnSize, current_string, 0, 0, n, 0);

    free(current_string);

    return result;
}