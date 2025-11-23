#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void backtrack(char **result, char *digits, char **mapping, int index, int *returnSize, char *current, int *currentIndex) {
    if (index == strlen(digits)) {
        result[*returnSize] = (char *)malloc((*currentIndex + 1) * sizeof(char));
        strncpy(result[*returnSize], current, *currentIndex);
        result[*returnSize][*currentIndex] = '\0';
        (*returnSize)++;
        return;
    }

    int digit = digits[index] - '2';
    char *letters = mapping[digit];
    for (int i = 0; letters[i] != '\0'; i++) {
        current[*currentIndex] = letters[i];
        (*currentIndex)++;
        backtrack(result, digits, mapping, index + 1, returnSize, current, currentIndex);
        (*currentIndex)--;
    }
}

char **letterCombinations(char *digits, int *returnSize) {
    if (digits == NULL || strlen(digits) == 0) {
        *returnSize = 0;
        return NULL;
    }

    char *mapping[] = {
        "", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"
    };

    char **result = (char **)malloc(1000 * sizeof(char *));
    char current[10];
    int currentIndex = 0;
    *returnSize = 0;

    backtrack(result, digits, mapping, 0, returnSize, current, &currentIndex);
    return result;
}