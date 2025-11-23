#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

bool wordPattern(char * pattern, char * s) {
    int patternLen = strlen(pattern);
    char *sCopy = strdup(s); // Create a mutable copy of s for strtok

    // charToStringMap maps a pattern character ('a' through 'z') to a word string.
    // It stores pointers to words within sCopy.
    char *charToStringMap[26] = {NULL}; 

    // stringToCharMap maps a word string to a pattern character.
    // We use two arrays: one for keys (word pointers) and one for values (chars).
    // The maximum number of unique words is patternLen.
    char *stringToCharMapKeys[patternLen]; 
    char stringToCharMapValues[patternLen];
    int uniqueWordCount = 0; // Tracks the number of unique words encountered

    char *currentWord = strtok(sCopy, " "); // Get the first word

    for (int i = 0; i < patternLen; i++) {
        char pChar = pattern[i];

        // If pattern has more characters but s has no more words, it's a mismatch.
        if (currentWord == NULL) {
            free(sCopy);
            return false;
        }

        // --- Check charToStringMap (pattern char -> word) ---
        int charIdx = pChar - 'a';
        if (charToStringMap[charIdx] == NULL) {
            // This pattern character is seen for the first time.
            // Map it to the current word.
            charToStringMap[charIdx] = currentWord;
        } else {
            // This pattern character has been seen before.
            // Check if it maps to the same word. If not, it's a mismatch.
            if (strcmp(charToStringMap[charIdx], currentWord) != 0) {
                free(sCopy);
                return false;
            }
        }

        // --- Check stringToCharMap (word -> pattern char) ---
        int wordFoundIdx = -1;
        // Search if currentWord has been seen before.
        for (int j = 0; j < uniqueWordCount; j++) {
            if (strcmp(stringToCharMapKeys[j], currentWord) == 0) {
                wordFoundIdx = j;
                break;
            }
        }

        if (wordFoundIdx == -1) {
            // This word is seen for the first time.
            // Map it to the current pattern character.
            stringToCharMapKeys[uniqueWordCount] = currentWord;
            stringToCharMapValues[uniqueWordCount] = pChar;
            uniqueWordCount++;
        } else {
            // This word has been seen before.
            // Check if it maps to the same pattern character. If not, it's a mismatch.
            if (stringToCharMapValues[wordFoundIdx] != pChar) {
                free(sCopy);
                return false;
            }
        }

        currentWord = strtok(NULL, " "); // Get the next word
    }

    // After iterating through the pattern, if there are still words left in s,
    // it means s has more words than pattern has characters. This is a mismatch.
    if (currentWord != NULL) {
        free(sCopy);
        return false;
    }

    free(sCopy); // Free the duplicated string
    return true;
}