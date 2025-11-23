#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char** result_arr;
int result_count;
int result_capacity;

void backtrack(char* s, int index, char* current_permutation, int s_len) {
    if (index == s_len) {
        char* new_str = (char*)malloc((s_len + 1) * sizeof(char));
        strcpy(new_str, current_permutation);

        if (result_count == result_capacity) {
            result_capacity *= 2;
            result_arr = (char**)realloc(result_arr, result_capacity * sizeof(char*));
        }
        result_arr[result_count++] = new_str;
        return;
    }

    if (isalpha(s[index])) {
        current_permutation[index] = tolower(s[index]);
        backtrack(s, index + 1, current_permutation, s_len);

        current_permutation[index] = toupper(s[index]);
        backtrack(s, index + 1, current_permutation, s_len);
    } else {
        current_permutation[index] = s[index];
        backtrack(s, index + 1, current_permutation, s_len);
    }
}

char** letterCasePermutation(char* s, int* returnSize) {
    int s_len = strlen(s);

    result_count = 0;
    result_capacity = 1;
    result_arr = (char**)malloc(result_capacity * sizeof(char*));

    char* current_permutation = (char*)malloc((s_len + 1) * sizeof(char));
    current_permutation[s_len] = '\0';

    backtrack(s, 0, current_permutation, s_len);

    *returnSize = result_count;

    free(current_permutation);

    return result_arr;
}