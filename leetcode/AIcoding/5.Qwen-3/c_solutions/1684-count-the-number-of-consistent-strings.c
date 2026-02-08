#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countConsistentStrings(char** allowed, int allowedSize, char** words, int wordsSize) {
    int allowedSet[26] = {0};
    for (int i = 0; i < allowedSize; i++) {
        allowedSet[allowed[i][0] - 'a'] = 1;
    }

    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        int valid = 1;
        for (int j = 0; j < strlen(words[i]); j++) {
            if (allowedSet[words[i][j] - 'a'] != 1) {
                valid = 0;
                break;
            }
        }
        if (valid) count++;
    }
    return count;
}