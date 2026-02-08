#include <stdlib.h>
#include <string.h>

void backtrack(char** result, int* result_idx, char* current_string, int open_count, int close_count, int max_n, int current_pos) {
    if (current_pos == 2 * max_n) {
        current_string[current_pos] = '\0';
        result[*result_idx] = strdup(current_string);
        (*result_idx)++;
        return;
    }

    if (open_count < max_n) {
        current_string[current_pos] = '(';
        backtrack(result, result_idx, current_string, open_count + 1, close_count, max_n, current_pos + 1);
    }

    if (close_count < open_count) {
        current_string[current_pos] = ')';
        backtrack(result, result_idx, current_string, open_count, close_count + 1, max_n, current_pos + 1);
    }
}

char** generateParenthesis(int n, int* returnSize) {
    char** result = (char**)malloc(sizeof(char*) * 1500); 
    char* current_string = (char*)malloc(sizeof(char) * (2 * n + 1));
    int result_idx = 0;

    backtrack(result, &result_idx, current_string, 0, 0, n, 0);

    *returnSize = result_idx;

    free(current_string);

    return result;
}