#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

bool wordPattern(char * pattern, char * s) {
    char *words[5000]; // Array to store pointers to words
    int word_count = 0;

    // Duplicate s as strtok modifies the string
    char *s_copy = strdup(s);
    if (s_copy == NULL) {
        return false; // Memory allocation failed
    }

    // Tokenize the string s_copy by space delimiter
    char *token = strtok(s_copy, " ");
    while (token != NULL) {
        if (word_count >= 5000) { // Prevent buffer overflow for words array
            free(s_copy);
            return false;
        }
        words[word_count++] = token;
        token = strtok(NULL, " ");
    }

    // If the number of words does not match the pattern length, it's a mismatch
    if (word_count != strlen(pattern)) {
        free(s_copy);
        return false;
    }

    // char_to_word_map: maps a character from 'a' to 'z' to a word (char*)
    char *char_to_word_map[26] = {NULL};

    for (int i = 0; i < strlen(pattern); i++) {
        char p_char = pattern[i];
        char *current_word = words[i];
        int p_idx = p_char - 'a'; // Convert char to 0-25 index

        if (char_to_word_map[p_idx] == NULL) {
            // This pattern character has not been seen before.
            // Check if the current_word has already been mapped by a *different* pattern character.
            for (int j = 0; j < 26; j++) {
                if (char_to_word_map[j] != NULL && strcmp(char_to_word_map[j], current_word) == 0) {
                    // current_word is already mapped by a different pattern character, violating bijection
                    free(s_copy);
                    return false;
                }
            }
            // If not mapped by any other char, establish the new mapping
            char_to_word_map[p_idx] = current_word;
        } else {
            // This pattern character has been seen before.
            // Check if it maps to the same word as before.
            if (strcmp(char_to_word_map[p_idx], current_word) != 0) {
                // Mismatch: p_char previously mapped to a different word
                free(s_copy);
                return false;
            }
        }
    }

    // Free the duplicated string
    free(s_copy);
    return true;
}