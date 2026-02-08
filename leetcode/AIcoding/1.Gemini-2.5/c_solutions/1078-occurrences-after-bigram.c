#include <stdlib.h>
#include <string.h>

char **findOcurrences(char *text, char *first, char *second, int *returnSize) {
    int capacity = 10;
    char **results = (char **)malloc(capacity * sizeof(char *));
    *returnSize = 0;

    char *text_copy = strdup(text); // Create a mutable copy of the input string
    char *token;
    char *rest = text_copy;

    char *prev_prev_word = NULL; // Stores the word before prev_word
    char *prev_word = NULL;      // Stores the word before the current token

    // strtok_r is a reentrant version of strtok, suitable for parsing
    while ((token = strtok_r(rest, " ", &rest)) != NULL) {
        // 'token' is the current word being processed

        // Check if the bigram (first, second) was found in the previous two words
        if (prev_prev_word != NULL && prev_word != NULL) {
            if (strcmp(prev_prev_word, first) == 0 && strcmp(prev_word, second) == 0) {
                // If the bigram matches, 'token' is the word that follows it
                if (*returnSize == capacity) {
                    capacity *= 2;
                    results = (char **)realloc(results, capacity * sizeof(char *));
                }
                // Store a dynamically allocated copy of the 'token'
                results[*returnSize] = strdup(token);
                (*returnSize)++;
            }
        }

        // Update the previous two words for the next iteration
        prev_prev_word = prev_word;
        prev_word = token;
    }

    free(text_copy); // Free the duplicated text string

    return results;
}