#include <stdlib.h>
#include <string.h>

const char* mapping[] = {
    "",     // 0
    "",     // 1
    "abc",  // 2
    "def",  // 3
    "ghi",  // 4
    "jkl",  // 5
    "mno",  // 6
    "pqrs", // 7
    "tuv",  // 8
    "wxyz"  // 9
};

void backtrack(char* digits, int index, char* current_combination, int digits_len,
               char*** result, int* result_size, int* result_capacity) {
    if (index == digits_len) {
        current_combination[digits_len] = '\0';

        if (*result_size == *result_capacity) {
            *result_capacity = (*result_capacity == 0) ? 1 : (*result_capacity * 2);
            *result = (char**)realloc(*result, sizeof(char*) * (*result_capacity));
        }

        (*result)[*result_size] = (char*)malloc(sizeof(char) * (digits_len + 1));
        strcpy((*result)[*result_size], current_combination);
        (*result_size)++;
        return;
    }

    char digit_char = digits[index];
    int digit = digit_char - '0';
    const char* letters = mapping[digit];

    for (int i = 0; letters[i] != '\0'; i++) {
        current_combination[index] = letters[i];
        backtrack(digits, index + 1, current_combination, digits_len,
                  result, result_size, result_capacity);
    }
}

char ** letterCombinations(char * digits, int* returnSize) {
    *returnSize = 0;
    int digits_len = strlen(digits);

    if (digits_len == 0) {
        return NULL;
    }

    char** result = NULL;
    int result_capacity = 0;

    char* current_combination = (char*)malloc(sizeof(char) * (digits_len + 1));

    backtrack(digits, 0, current_combination, digits_len,
              &result, returnSize, &result_capacity);

    free(current_combination);

    return result;
}