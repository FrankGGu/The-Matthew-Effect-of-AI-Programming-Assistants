#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countCharacters(char ** words, int wordsSize, char * chars) {
    int count[26] = {0};
    int total = 0;

    for (int i = 0; chars[i]; i++) {
        count[chars[i] - 'a']++;
    }

    for (int i = 0; i < wordsSize; i++) {
        int wordCount[26] = {0};
        int valid = 1;

        for (int j = 0; words[i][j]; j++) {
            wordCount[words[i][j] - 'a']++;
        }

        for (int k = 0; k < 26; k++) {
            if (wordCount[k] > count[k]) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            total += strlen(words[i]);
        }
    }

    return total;
}