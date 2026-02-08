#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countPrefixes(char ** words, int wordsSize, char * s) {
    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        if (len > strlen(s)) continue;
        int match = 1;
        for (int j = 0; j < len; j++) {
            if (words[i][j] != s[j]) {
                match = 0;
                break;
            }
        }
        if (match) count++;
    }
    return count;
}