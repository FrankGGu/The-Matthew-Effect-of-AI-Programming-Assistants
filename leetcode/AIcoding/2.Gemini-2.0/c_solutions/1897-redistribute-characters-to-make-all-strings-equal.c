#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool makeEqual(char ** words, int wordsSize){
    int count[26] = {0};
    int totalLength = 0;

    for (int i = 0; i < wordsSize; i++) {
        totalLength += strlen(words[i]);
        for (int j = 0; words[i][j] != '\0'; j++) {
            count[words[i][j] - 'a']++;
        }
    }

    if (totalLength % wordsSize != 0) {
        return false;
    }

    for (int i = 0; i < 26; i++) {
        if (count[i] % wordsSize != 0) {
            return false;
        }
    }

    return true;
}