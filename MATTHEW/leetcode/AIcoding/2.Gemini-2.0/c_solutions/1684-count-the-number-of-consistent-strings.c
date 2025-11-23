#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countConsistentStrings(char * allowed, char ** words, int wordsSize){
    bool allowedChars[26] = {false};
    for (int i = 0; allowed[i] != '\0'; i++) {
        allowedChars[allowed[i] - 'a'] = true;
    }

    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        bool consistent = true;
        for (int j = 0; words[i][j] != '\0'; j++) {
            if (!allowedChars[words[i][j] - 'a']) {
                consistent = false;
                break;
            }
        }
        if (consistent) {
            count++;
        }
    }

    return count;
}