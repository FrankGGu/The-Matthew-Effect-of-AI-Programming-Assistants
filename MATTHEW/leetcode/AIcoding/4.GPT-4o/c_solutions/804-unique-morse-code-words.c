#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORDS 100
#define MAX_MORSE_LEN 10

char* morseCode[] = {".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--.."};

int uniqueMorseRepresentations(char ** words, int wordsSize) {
    char **morseWords = (char **)malloc(sizeof(char *) * wordsSize);
    int count = 0;

    for (int i = 0; i < wordsSize; i++) {
        char *morse = (char *)malloc(MAX_WORDS * MAX_MORSE_LEN * sizeof(char));
        morse[0] = '\0';
        for (int j = 0; words[i][j] != '\0'; j++) {
            strcat(morse, morseCode[words[i][j] - 'a']);
        }
        morseWords[count++] = morse;
    }

    qsort(morseWords, count, sizeof(char *), (int (*)(const void *, const void *))strcmp);

    int uniqueCount = 0;
    for (int i = 0; i < count; i++) {
        if (i == 0 || strcmp(morseWords[i], morseWords[i - 1]) != 0) {
            uniqueCount++;
        }
        free(morseWords[i]);
    }

    free(morseWords);
    return uniqueCount;
}