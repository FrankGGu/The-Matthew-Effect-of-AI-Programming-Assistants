#include <stdlib.h>
#include <string.h>

const char* morse_codes[] = {
    ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---",
    "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-",
    "..-", "...-", ".--", "-..-", "-.--", "--.."
};

#define MAX_MORSE_WORD_LEN (12 * 4 + 1)

int compareStrings(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

int uniqueMorseRepresentations(char** words, int wordsSize) {
    if (wordsSize == 0) {
        return 0;
    }

    char** morse_representations = (char**)malloc(wordsSize * sizeof(char*));
    if (morse_representations == NULL) {
        return 0;
    }

    for (int i = 0; i < wordsSize; i++) {
        morse_representations[i] = (char*)malloc(MAX_MORSE_WORD_LEN * sizeof(char));
        if (morse_representations[i] == NULL) {
            for (int j = 0; j < i; j++) {
                free(morse_representations[j]);
            }
            free(morse_representations);
            return 0;
        }

        morse_representations[i][0] = '\0';

        char* word = words[i];
        for (int k = 0; word[k] != '\0'; k++) {
            strcat(morse_representations[i], morse_codes[word[k] - 'a']);
        }
    }

    qsort(morse_representations, wordsSize, sizeof(char*), compareStrings);

    int unique_count = 0;
    if (wordsSize > 0) {
        unique_count = 1;
        for (int i = 1; i < wordsSize; i++) {
            if (strcmp(morse_representations[i], morse_representations[i-1]) != 0) {
                unique_count++;
            }
        }
    }

    for (int i = 0; i < wordsSize; i++) {
        free(morse_representations[i]);
    }
    free(morse_representations);

    return unique_count;
}