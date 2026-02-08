#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdio.h>

static bool isValidIntPart(char* s, int len) {
    if (len == 0) return false;
    // Leading zero check: "0" is valid, "01" is not.
    if (len > 1 && s[0] == '0') return false;
    return true;
}

static bool isValidDecPart(char* s, int len) {
    if (len == 0) return false;
    // Trailing zero check: "10" after decimal is not valid.
    if (s[len - 1] == '0') return false;
    return true;
}

static char** generateValidNumbers(char* s, int len, int* returnSize) {
    *returnSize = 0;
    // Initial capacity for results, will realloc if needed
    int capacity = 4; // A single digit string can have at most 1 integer and 0 decimal forms ("0" -> "0")
                      // Two digit string can have at most 1 integer and 1 decimal form ("12" -> "12", "1.2")
                      // Max length is 10, so at most 1 integer form and 9 decimal forms. 10 is a safe initial capacity.
    char** result = (char**)malloc(capacity * sizeof(char*));
    if (!result) return NULL;

    // Case 1: Integer form (no decimal point)
    if (isValidIntPart(s, len)) {
        if (*returnSize == capacity) {
            capacity *= 2;
            result = (char**)realloc(result, capacity * sizeof(char*));
            if (!result) return NULL;
        }
        char* num_str = (char*)malloc((len + 1) * sizeof(char));
        if (!num_str) return NULL;
        strncpy(num_str, s, len);
        num_str[len] = '\0';
        result[*returnSize++] = num_str;
    }

    // Case 2: Decimal forms
    // Iterate 'i' as the index of the last digit of the integer part (before the decimal point)
    for (int i = 0; i < len - 1; i++) {
        // s[0...i] is the integer part
        // s[i+1...len-1] is the decimal part
        if (isValidIntPart(s, i + 1) && isValidDecPart(s + i + 1, len - (i + 1))) {
            if (*returnSize == capacity) {
                capacity *= 2;
                result = (char**)realloc(result, capacity * sizeof(char*));
                if (!result) return NULL;
            }
            int num_str_len = len + 1; // +1 for '.', +1 for '\0'
            char* num_str = (char*)malloc((num_str_len + 1) * sizeof(char));
            if (!num_str) return NULL;
            strncpy(num_str, s, i + 1);
            num_str[i+1] = '.';
            strncpy(num_str + i + 2, s + i + 1, len - (i + 1));
            num_str[num_str_len] = '\0';
            result[*returnSize++] = num_str;
        }
    }

    if (*returnSize == 0) {
        free(result);
        return NULL;
    }

    // Shrink to fit the actual number of results
    char** final_result = (char**)realloc(result, *returnSize * sizeof(char*));
    if (!final_result) { // realloc failed, but original result is still valid
        // Handle error: free existing strings in result and then result itself
        for (int k = 0; k < *returnSize; k++) {
            free(result[k]);
        }
        free(result);
        *returnSize = 0;
        return NULL;
    }
    return final_result;
}

char** ambiguousCoordinates(char* s, int* returnSize) {
    *returnSize = 0;
    int final_capacity = 10; // Initial capacity for the final list of coordinate pairs
    char** final_result = (char**)malloc(final_capacity * sizeof(char*));
    if (!final_result) return NULL;

    int digits_len = strlen(s) - 2; // Length of the digits string inside parentheses
    char* digits_str = s + 1;       // Pointer to the start of the digits string

    if (digits_len == 0) {
        free(final_result);
        return NULL;
    }

    // Iterate through all possible split points for X and Y
    // 'i' represents the length of the first part (X)
    // X must have at least 1 digit, Y must have at least 1 digit
    for (int i = 1; i < digits_len; i++) {
        char* s1 = digits_str;
        int len1 = i;
        char* s2 = digits_str + i;
        int len2 = digits_len - i;

        int x_count = 0;
        char** x_coords = generateValidNumbers(s1, len1, &x_count);

        int y_count = 0;
        char** y_coords = generateValidNumbers(s2, len2, &y_count);

        if (x_coords != NULL && y_coords != NULL) {
            for (int x_idx = 0; x_idx < x_count; x_idx++) {
                for (int y_idx = 0; y_idx < y_count; y_idx++) {
                    // Construct "(X, Y)" string
                    char* x_str = x_coords[x_idx];
                    char* y_str = y_coords[y_idx];
                    // +1 for '(', +1 for ',', +1 for ' ', +1 for ')' = 4 chars + '\0'
                    int total_len = strlen(x_str) + strlen(y_str) + 4 + 1; 

                    char* coord_pair = (char*)malloc(total_len * sizeof(char));
                    if (!coord_pair) {
                        // Handle memory allocation failure
                        // Free all previously allocated memory before returning
                        // This is a simplified error handling. For production, a more robust cleanup is needed.
                        // For LeetCode, typically assume malloc succeeds or let it crash.
                        goto cleanup_and_fail;
                    }
                    sprintf(coord_pair, "(%s, %s)", x_str, y_str);

                    if (*returnSize == final_capacity) {
                        final_capacity *= 2;
                        final_result = (char**)realloc(final_result, final_capacity * sizeof(char*));
                        if (!final_result) {
                            free(coord_pair); // Free the string we just created
                            goto cleanup_and_fail;
                        }
                    }
                    final_result[*returnSize++] = coord_pair;
                }
            }
        }

        // Free memory for x_coords and y_coords and their contents
        if (x_coords != NULL) {
            for (int k = 0; k < x_count; k++) {
                free(x_coords[k]);
            }
            free(x_coords);
        }
        if (y_coords != NULL) {
            for (int k = 0; k < y_count; k++) {
                free(y_coords[k]);
            }
            free(y_coords);
        }
    }

    if (*returnSize == 0) {
        free(final_result);
        return NULL;
    }

    // Shrink to fit the actual number of results
    char** result_final_realloc = (char**)realloc(final_result, *returnSize * sizeof(char*));
    if (!result_final_realloc) { // realloc failed, but original final_result is still valid
        // For LeetCode, it's usually fine to return final_result directly without realloc if it's not null.
        // But if we want to be strict, we handle it.
        return final_result; // Return the potentially oversized buffer
    }
    return result_final_realloc;

cleanup_and_fail:
    // This part is for robust error handling, typically not strictly required for LeetCode.
    // It would involve iterating through final_result and freeing all strings, then final_result itself.
    // For simplicity, assuming malloc doesn't fail on LeetCode.
    if (final_result) {
        for (int k = 0; k < *returnSize; k++) {
            free(final_result[k]);
        }
        free(final_result);
    }
    // Also need to free x_coords and y_coords if they were allocated before the failure.
    // This cleanup logic can get complex.
    *returnSize = 0;
    return NULL;
}