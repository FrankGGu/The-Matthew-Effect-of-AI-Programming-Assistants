#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **letterCombinations(char *digits, int *returnSize) {
    if (digits == NULL || strlen(digits) == 0) {
        *returnSize = 0;
        return NULL;
    }

    const char *mapping[] = {"", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};
    int n = strlen(digits);
    int total = 1;
    for (int i = 0; i < n; i++) {
        total *= strlen(mapping[digits[i] - '0']);
    }

    char **result = (char **)malloc(total * sizeof(char *));
    *returnSize = total;

    int *indexes = (int *)calloc(n, sizeof(int));
    for (int i = 0; i < total; i++) {
        result[i] = (char *)malloc((n + 1) * sizeof(char));
        for (int j = 0; j < n; j++) {
            result[i][j] = mapping[digits[j] - '0'][indexes[j]];
        }
        result[i][n] = '\0';

        int carry = 1;
        for (int j = n - 1; j >= 0 && carry; j--) {
            indexes[j] += carry;
            carry = indexes[j] / strlen(mapping[digits[j] - '0']);
            indexes[j] %= strlen(mapping[digits[j] - '0']);
        }
    }

    free(indexes);
    return result;
}