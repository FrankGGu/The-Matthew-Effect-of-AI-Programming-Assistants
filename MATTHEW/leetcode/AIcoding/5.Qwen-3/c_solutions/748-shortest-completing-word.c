#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* shortestCompletingWord(char* licensePlate, char** words, int wordsSize) {
    int licenseFreq[26] = {0};
    for (int i = 0; licensePlate[i]; i++) {
        char c = tolower(licensePlate[i]);
        if (c >= 'a' && c <= 'z') {
            licenseFreq[c - 'a']++;
        }
    }

    char* result = NULL;
    int minLen = INT_MAX;

    for (int i = 0; i < wordsSize; i++) {
        int wordFreq[26] = {0};
        for (int j = 0; words[i][j]; j++) {
            char c = tolower(words[i][j]);
            if (c >= 'a' && c <= 'z') {
                wordFreq[c - 'a']++;
            }
        }

        int valid = 1;
        for (int k = 0; k < 26; k++) {
            if (licenseFreq[k] > wordFreq[k]) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            int len = strlen(words[i]);
            if (len < minLen) {
                minLen = len;
                result = words[i];
            }
        }
    }

    return result;
}