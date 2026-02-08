#include <stdlib.h>
#include <string.h>
#include <stdio.h>

char *evaluate(char *s, char ***knowledge, int knowledgeSize, int *knowledgeColSize) {
    int s_len = strlen(s);
    // Initial buffer capacity. Max possible length can be s_len * max_value_len.
    // A reasonable start is s_len * 2 or a fixed minimum.
    // Max value length is 10. If s is all (key) and keys are replaced by 10-char values,
    // result length could be s_len / 3 * 10.
    // Let's start with s_len * 4 as a heuristic to reduce reallocations.
    int current_capacity = (s_len > 0 ? s_len * 4 : 100);
    char *result = (char *)malloc(sizeof(char) * current_capacity);
    if (result == NULL) {
        return NULL; // Allocation failed
    }
    result[0] = '\0'; // Initialize as an empty string
    int result_len = 0;

    int i = 0;
    while (s[i] != '\0') {
        if (s[i] == '(') {
            // Find the closing parenthesis
            int j = i + 1;
            while (s[j] != '\0' && s[j] != ')') {
                j++;
            }

            // Extract the key string
            int key_len = j - (i + 1);
            char *key = (char *)malloc(sizeof(char) * (key_len + 1));
            if (key == NULL) {
                free(result);
                return NULL; // Allocation failed
            }
            strncpy(key, s + i + 1, key_len);
            key[key_len] = '\0'; // Null-terminate the extracted key

            // Search for the key in the knowledge array
            char *value_to_append = "?"; // Default if key not found
            for (int k = 0; k < knowledgeSize; k++) {
                if (strcmp(knowledge[k][0], key) == 0) {
                    value_to_append = knowledge[k][1];
                    break;
                }
            }

            // Append the found value (or '?') to the result string
            int value_len = strlen(value_to_append);
            if (result_len + value_len + 1 > current_capacity) {
                current_capacity = (result_len + value_len + 1) * 2; // Double capacity
                char *new_result = (char *)realloc(result, sizeof(char) * current_capacity);
                if (new_result == NULL) {
                    free(result);
                    free(key);
                    return NULL; // Reallocation failed
                }
                result = new_result;
            }
            strcat(result, value_to_append);
            result_len += value_len;

            free(key); // Free the temporary key string

            // Move past the ')'
            i = j + 1;
        } else {
            // Append a regular character
            if (result_len + 2 > current_capacity) { // +1 for char, +1 for null terminator
                current_capacity = (result_len + 2) * 2;
                char *new_result = (char *)realloc(result, sizeof(char) * current_capacity);
                if (new_result == NULL) {
                    free(result);
                    return NULL; // Reallocation failed
                }
                result = new_result;
            }
            result[result_len++] = s[i];
            result[result_len] = '\0'; // Ensure null-termination
            i++;
        }
    }

    return result;
}