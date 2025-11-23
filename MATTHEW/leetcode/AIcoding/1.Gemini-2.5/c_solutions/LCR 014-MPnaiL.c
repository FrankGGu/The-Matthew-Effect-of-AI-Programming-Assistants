#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int compareChars(const void* a, const void* b) {
    return (*(char*)a - *(char*)b);
}

void backtrack(char* s, int len, char* current_permutation, int k, bool* used, 
               char*** result, int* result_size, int* result_capacity) {

    // Base case: if the current permutation has reached the length of the original string
    if (k == len) {
        // Expand result array if capacity is reached
        if (*result_size == *result_capacity) {
            *result_capacity *= 2;
            if (*result_capacity == 0) *result_capacity = 1; // Ensure capacity is at least 1
            *result = (char**)realloc(*result, sizeof(char*) * (*result_capacity));
            // In a real-world scenario, error checking for realloc would be needed
            // if (*result == NULL) {  }
        }
        // Allocate memory for the new permutation string and copy it
        (*result)[*result_size] = (char*)malloc(sizeof(char) * (len + 1));
        strcpy((*result)[*result_size], current_permutation);
        (*result_size)++;
        return;
    }

    // Iterate through all characters of the original string
    for (int i = 0; i < len; i++) {
        // If the character at index i has already been used in the current permutation, skip it
        if (used[i]) {
            continue;
        }

        // Handle duplicates:
        // If the current character is the same as the previous one (s[i] == s[i-1]),
        // AND the previous one was NOT used (!used[i-1]),
        // it means s[i-1] was part of a different branch that has already been explored.
        // Skipping s[i] prevents generating duplicate permutations (e.g., for "AAB", avoid two "AAB"s).
        if (i > 0 && s[i] == s[i-1] && !used[i-1]) {
            continue;
        }

        // Mark the character as used
        used[i] = true;
        // Add the character to the current permutation
        current_permutation[k] = s[i];
        current_permutation[k + 1] = '\0'; // Null-terminate the string

        // Recurse to build the next part of the permutation
        backtrack(s, len, current_permutation, k + 1, used, result, result_size, result_capacity);

        // Backtrack: unmark the character as used
        used[i] = false;
        // Remove the character from the current permutation (by setting null terminator)
        current_permutation[k] = '\0'; 
    }
}

char** permutation(char* s, int* returnSize) {
    // Handle null input string
    if (s == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int len = strlen(s);
    // Handle empty input string
    if (len == 0) {
        *returnSize = 0;
        return NULL;
    }

    // Create a mutable copy of the input string because qsort modifies it in place.
    // This is important if `s` points to a string literal.
    char* mutable_s = (char*)malloc(sizeof(char) * (len + 1));
    strcpy(mutable_s, s);

    // Sort the mutable string. This is crucial for the duplicate handling logic in backtrack.
    qsort(mutable_s, len, sizeof(char), compareChars);

    // Initialize the result array (array of char pointers) with an initial capacity
    char** result = (char**)malloc(sizeof(char*) * 10); 
    int result_size = 0;
    int result_capacity = 10;

    // Initialize the current permutation string
    char* current_permutation = (char*)malloc(sizeof(char) * (len + 1));
    current_permutation[0] = '\0'; // Start with an empty string

    // Initialize a boolean array to keep track of used characters
    // calloc initializes all elements to false (0)
    bool* used = (bool*)calloc(len, sizeof(bool)); 

    // Start the backtracking process
    backtrack(mutable_s, len, current_permutation, 0, used, &result, &result_size, &result_capacity);

    // Free dynamically allocated temporary memory
    free(current_permutation);
    free(used);
    free(mutable_s);

    // Set the returnSize for the caller
    *returnSize = result_size;
    // Return the array of permutation strings
    return result;
}