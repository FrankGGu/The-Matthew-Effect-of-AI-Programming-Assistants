#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxPalindromesAfterOperations(char ** words, int wordsSize){
    int counts[26] = {0};
    int totalLength = 0;
    for (int i = 0; i < wordsSize; i++) {
        totalLength += strlen(words[i]);
        for (int j = 0; words[i][j] != '\0'; j++) {
            counts[words[i][j] - 'a']++;
        }
    }

    int pairs = 0;
    for (int i = 0; i < 26; i++) {
        pairs += counts[i] / 2;
    }

    return pairs >= totalLength / 2 ? wordsSize : pairs;
}