#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * shortestCompletingWord(char * licensePlate, char ** words, int wordsSize){
    int license_freq[26] = {0};
    int len = strlen(licensePlate);
    for (int i = 0; i < len; i++) {
        if (isalpha(licensePlate[i])) {
            license_freq[tolower(licensePlate[i]) - 'a']++;
        }
    }

    char *shortest = NULL;
    int shortest_len = INT_MAX;

    for (int i = 0; i < wordsSize; i++) {
        int word_freq[26] = {0};
        int word_len = strlen(words[i]);
        for (int j = 0; j < word_len; j++) {
            word_freq[tolower(words[i][j]) - 'a']++;
        }

        int complete = 1;
        for (int k = 0; k < 26; k++) {
            if (license_freq[k] > word_freq[k]) {
                complete = 0;
                break;
            }
        }

        if (complete) {
            if (word_len < shortest_len) {
                shortest_len = word_len;
                shortest = words[i];
            }
        }
    }

    return shortest;
}