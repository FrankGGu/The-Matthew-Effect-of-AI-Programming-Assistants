#include <stdlib.h>
#include <string.h>
#include <stdio.h>

char ** commonChars(char ** words, int wordsSize, int* returnSize) {
    if (wordsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int min_freq[26];
    for (int i = 0; i < 26; i++) {
        min_freq[i] = 0;
    }

    // Initialize min_freq with the frequencies of the first word
    for (int i = 0; i < strlen(words[0]); i++) {
        min_freq[words[0][i] - 'a']++;
    }

    // Iterate through the remaining words
    for (int i = 1; i < wordsSize; i++) {
        int current_freq[26];
        for (int j = 0; j < 26; j++) {
            current_freq[j] = 0;
        }

        // Calculate frequencies for the current word
        for (int j = 0; j < strlen(words[i]); j++) {
            current_freq[words[i][j] - 'a']++;
        }

        // Update min_freq by taking the minimum of current_freq and min_freq
        for (int j = 0; j < 26; j++) {
            if (current_freq[j] < min_freq[j]) {
                min_freq[j] = current_freq[j];
            }
        }
    }

    // Allocate memory for the result array
    // Max possible common characters: 26 (distinct chars) * 100 (max frequency) = 2600
    char** result = (char**)malloc(sizeof(char*) * (26 * 100));
    *returnSize = 0;

    // Populate the result array based on min_freq
    for (int i = 0; i < 26; i++) {
        while (min_freq[i] > 0) {
            char* common_char_str = (char*)malloc(sizeof(char) * 2); // For char and null terminator
            common_char_str[0] = (char)('a' + i);
            common_char_str[1] = '\0';
            result[*returnSize] = common_char_str;
            (*returnSize)++;
            min_freq[i]--;
        }
    }

    return result;
}