#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

char* minRemoveToMakeValid(char* s) {
    int len = strlen(s);
    bool* to_remove = (bool*)calloc(len, sizeof(bool));
    if (to_remove == NULL) {
        // Handle allocation failure
        char* empty_str = (char*)malloc(1);
        if (empty_str != NULL) {
            empty_str[0] = '\0';
        }
        return empty_str;
    }

    // Pass 1: Mark invalid ')' from left to right
    int balance = 0;
    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            balance++;
        } else if (s[i] == ')') {
            if (balance > 0) {
                balance--;
            } else {
                to_remove[i] = true; // Mark this ')' for removal
            }
        }
    }

    // Pass 2: Mark invalid '(' from right to left
    balance = 0;
    for (int i = len - 1; i >= 0; i--) {
        if (s[i] == ')') {
            balance++;
        } else if (s[i] == '(') {
            if (balance > 0) {
                balance--;
            } else {
                to_remove[i] = true; // Mark this '(' for removal
            }
        }
    }

    // Pass 3: Build the result string
    int result_len = 0;
    for (int i = 0; i < len; i++) {
        if (!to_remove[i]) {
            result_len++;
        }
    }

    char* result = (char*)malloc(result_len + 1);
    if (result == NULL) {
        free(to_remove);
        // Handle allocation failure
        char* empty_str = (char*)malloc(1);
        if (empty_str != NULL) {
            empty_str[0] = '\0';
        }
        return empty_str;
    }

    int result_idx = 0;
    for (int i = 0; i < len; i++) {
        if (!to_remove[i]) {
            result[result_idx++] = s[i];
        }
    }
    result[result_idx] = '\0';

    free(to_remove);
    return result;
}