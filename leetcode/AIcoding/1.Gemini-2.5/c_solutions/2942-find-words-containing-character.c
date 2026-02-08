#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int* findWordsContaining(char** words, int wordsSize, char x, int* returnSize) {
    int* result = NULL;
    int count = 0;

    // First pass to count how many words contain the character x
    for (int i = 0; i < wordsSize; i++) {
        bool found = false;
        for (int j = 0; words[i][j] != '\0'; j++) {
            if (words[i][j] == x) {
                found = true;
                break;
            }
        }
        if (found) {
            count++;
        }
    }

    // Allocate memory for the result array
    result = (int*)malloc(count * sizeof(int));
    if (result == NULL) {
        *returnSize = 0;
        return NULL; // Handle malloc failure
    }

    // Second pass to populate the result array with indices
    int currentResultIndex = 0;
    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; words[i][j] != '\0'; j++) {
            if (words[i][j] == x) {
                result[currentResultIndex++] = i;
                break; // Move to the next word once character is found
            }
        }
    }

    *returnSize = count;
    return result;
}