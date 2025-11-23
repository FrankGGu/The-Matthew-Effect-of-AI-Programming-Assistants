#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

static bool areAnagrams(char* s1, char* s2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    if (len1 != len2) {
        return false;
    }

    int freq[26] = {0}; // For lowercase English letters 'a' through 'z'

    for (int i = 0; i < len1; i++) {
        freq[s1[i] - 'a']++;
        freq[s2[i] - 'a']--;
    }

    for (int i = 0; i < 26; i++) {
        if (freq[i] != 0) {
            return false;
        }
    }
    return true;
}

char** removeAnagrams(char** words, int wordsSize, int* returnSize) {
    if (wordsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    // Allocate memory for the resultant array of string pointers.
    // The maximum possible size is wordsSize.
    char** result = (char**)malloc(sizeof(char*) * wordsSize);
    if (result == NULL) {
        *returnSize = 0;
        return NULL; // Memory allocation failed
    }

    int resultIdx = 0;

    // The first word is always added to the resultant array.
    result[resultIdx] = strdup(words[0]);
    if (result[resultIdx] == NULL) {
        free(result); // Free the array itself
        *returnSize = 0;
        return NULL; // strdup failed
    }
    resultIdx++;

    // Iterate through the rest of the words
    for (int i = 1; i < wordsSize; i++) {
        // Compare the current word with the last word added to the result array
        if (!areAnagrams(result[resultIdx - 1], words[i])) {
            result[resultIdx] = strdup(words[i]);
            if (result[resultIdx] == NULL) {
                // Free all previously duplicated strings and the result array
                for (int j = 0; j < resultIdx; j++) {
                    free(result[j]);
                }
                free(result);
                *returnSize = 0;
                return NULL; // strdup failed
            }
            resultIdx++;
        }
    }

    *returnSize = resultIdx;

    // Reallocate the result array to its exact size to save memory.
    // If realloc fails, it returns NULL, and the original 'result' pointer is still valid.
    // In that case, we return the original 'result' which might be larger than needed.
    char** finalResult = (char**)realloc(result, sizeof(char*) * resultIdx);
    if (finalResult == NULL) {
        return result; // Return the original, possibly oversized, array
    }

    return finalResult;
}