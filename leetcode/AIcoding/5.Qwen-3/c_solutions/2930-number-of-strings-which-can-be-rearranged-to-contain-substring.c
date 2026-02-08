#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countStrings(char** words, int wordsSize) {
    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int len = strlen(word);
        int hasSubstring = 0;
        for (int j = 0; j <= len - 4; j++) {
            if (word[j] == 'a' && word[j+1] == 'b' && word[j+2] == 'c' && word[j+3] == 'd') {
                hasSubstring = 1;
                break;
            }
        }
        if (hasSubstring) {
            count++;
        }
    }
    return count;
}