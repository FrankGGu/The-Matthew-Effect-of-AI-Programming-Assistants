#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPrefixString(char* s, char** words, int wordsSize) {
    int i = 0;
    int j = 0;
    int len = strlen(s);
    int wordIndex = 0;

    while (j < len && wordIndex < wordsSize) {
        int wordLen = strlen(words[wordIndex]);
        if (j + wordLen > len) return false;
        for (i = 0; i < wordLen; i++) {
            if (s[j + i] != words[wordIndex][i]) return false;
        }
        j += wordLen;
        wordIndex++;
    }

    return j == len;
}