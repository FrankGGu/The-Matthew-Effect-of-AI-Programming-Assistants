#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int charToNum(char c) {
    return c - 'a' + 1;
}

long long wordToNum(char* word) {
    long long num = 0;
    for (int i = 0; word[i]; i++) {
        num = num * 10 + charToNum(word[i]);
    }
    return num;
}

bool isSumEqual(char* firstWord, char* secondWord, char* targetWord) {
    return wordToNum(firstWord) + wordToNum(secondWord) == wordToNum(targetWord);
}