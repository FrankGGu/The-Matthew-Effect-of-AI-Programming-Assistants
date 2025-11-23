#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countCharacters(char ** words, int wordsSize, char * chars){
    int char_freq[26] = {0};
    for (int i = 0; chars[i] != '\0'; i++) {
        char_freq[chars[i] - 'a']++;
    }

    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        int word_freq[26] = {0};
        int possible = 1;
        for (int j = 0; words[i][j] != '\0'; j++) {
            word_freq[words[i][j] - 'a']++;
        }

        for (int k = 0; k < 26; k++) {
            if (word_freq[k] > char_freq[k]) {
                possible = 0;
                break;
            }
        }

        if (possible) {
            count += strlen(words[i]);
        }
    }

    return count;
}