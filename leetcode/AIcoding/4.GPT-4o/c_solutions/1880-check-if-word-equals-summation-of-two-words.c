#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int getValue(char *word) {
    int value = 0;
    for (int i = 0; word[i] != '\0'; i++) {
        value = value * 10 + (word[i] - 'a');
    }
    return value;
}

bool isSumEqual(char *firstWord, char *secondWord, char *targetWord) {
    return getValue(firstWord) + getValue(secondWord) == getValue(targetWord);
}