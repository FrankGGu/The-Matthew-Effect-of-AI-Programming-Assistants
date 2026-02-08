#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int canBeTypedWords(char* text, char* brokenLetters) {
    int broken[26] = {0};
    for (int i = 0; brokenLetters[i]; i++) {
        broken[brokenLetters[i] - 'a'] = 1;
    }

    int count = 0;
    int wordStart = 1;
    for (int i = 0; text[i]; i++) {
        if (text[i] == ' ') {
            wordStart = 1;
        } else if (broken[text[i] - 'a']) {
            wordStart = 0;
        } else if (wordStart) {
            wordStart = 0;
            count++;
        }
    }

    return count;
}