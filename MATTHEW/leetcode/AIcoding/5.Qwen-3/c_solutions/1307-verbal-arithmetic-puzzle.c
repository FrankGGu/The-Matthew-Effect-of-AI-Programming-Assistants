#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_VARS 10
#define MAX_WORD_LEN 20

typedef struct {
    char var;
    int value;
} Var;

bool is_valid(char** words, int wordsSize, char* result, int* mapping, int* used, int index, int carry) {
    if (index == MAX_WORD_LEN) {
        return carry == 0;
    }

    int sum = carry;
    for (int i = 0; i < wordsSize; i++) {
        if (words[i][index] != '\0') {
            sum += mapping[words[i][index] - 'A'];
        }
    }
    sum += mapping[result[index] - 'A'];

    if (sum % 10 != mapping[result[index] - 'A']) {
        return false;
    }

    int new_carry = sum / 10;

    for (int i = 0; i < wordsSize; i++) {
        if (words[i][index] != '\0' && mapping[words[i][index] - 'A'] == -1) {
            for (int d = 0; d <= 9; d++) {
                if (!used[d]) {
                    mapping[words[i][index] - 'A'] = d;
                    used[d] = true;
                    if (is_valid(words, wordsSize, result, mapping, used, index, new_carry)) {
                        return true;
                    }
                    mapping[words[i][index] - 'A'] = -1;
                    used[d] = false;
                }
            }
            return false;
        }
    }

    if (mapping[result[index] - 'A'] == -1) {
        for (int d = 0; d <= 9; d++) {
            if (!used[d]) {
                mapping[result[index] - 'A'] = d;
                used[d] = true;
                if (is_valid(words, wordsSize, result, mapping, used, index, new_carry)) {
                    return true;
                }
                mapping[result[index] - 'A'] = -1;
                used[d] = false;
            }
        }
        return false;
    }

    return is_valid(words, wordsSize, result, mapping, used, index + 1, new_carry);
}

bool is_letter(char c) {
    return c >= 'A' && c <= 'Z';
}

bool is_valid_solution(char** words, int wordsSize, char* result, int* mapping) {
    int len = strlen(result);
    for (int i = 0; i < len; i++) {
        int sum = 0;
        for (int j = 0; j < wordsSize; j++) {
            if (i < strlen(words[j])) {
                sum += mapping[words[j][i] - 'A'];
            }
        }
        sum += mapping[result[i] - 'A'];
        if (sum % 10 != mapping[result[i] - 'A']) {
            return false;
        }
    }
    return true;
}

bool solve(char** words, int wordsSize, char* result) {
    int max_len = 0;
    for (int i = 0; i < wordsSize; i++) {
        max_len = fmax(max_len, (int)strlen(words[i]));
    }
    max_len = fmax(max_len, (int)strlen(result));

    int mapping[MAX_VARS];
    memset(mapping, -1, sizeof(mapping));
    int used[10] = {0};

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < (int)strlen(words[i]); j++) {
            if (is_letter(words[i][j])) {
                mapping[words[i][j] - 'A'] = -1;
            }
        }
    }
    for (int j = 0; j < (int)strlen(result); j++) {
        if (is_letter(result[j])) {
            mapping[result[j] - 'A'] = -1;
        }
    }

    for (int i = 0; i < MAX_VARS; i++) {
        if (mapping[i] == -1) {
            mapping[i] = 0;
        }
    }

    for (int i = 0; i < MAX_VARS; i++) {
        if (mapping[i] == -1) {
            for (int d = 0; d <= 9; d++) {
                mapping[i] = d;
                used[d] = 1;
                if (is_valid(words, wordsSize, result, mapping, used, 0, 0)) {
                    return true;
                }
                mapping[i] = -1;
                used[d] = 0;
            }
            return false;
        }
    }

    return is_valid_solution(words, wordsSize, result, mapping);
}

bool isSolvable(char** words, int wordsSize, char* result) {
    return solve(words, wordsSize, result);
}