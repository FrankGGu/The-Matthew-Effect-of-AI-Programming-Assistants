#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int totalCharacters(char ** words, int wordsSize) {
    int totalChars = 0;
    for (int i = 0; i < wordsSize; i++) {
        totalChars += strlen(words[i]);
    }
    return totalChars;
}