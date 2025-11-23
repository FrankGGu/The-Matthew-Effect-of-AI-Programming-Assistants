#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** commonChars(char ** words, int wordsSize, int* returnSize){
    int freq[26] = {0};
    for (int i = 0; i < 26; i++) {
        freq[i] = 101;
    }

    for (int i = 0; i < wordsSize; i++) {
        int wordFreq[26] = {0};
        for (int j = 0; words[i][j] != '\0'; j++) {
            wordFreq[words[i][j] - 'a']++;
        }
        for (int k = 0; k < 26; k++) {
            freq[k] = (freq[k] < wordFreq[k]) ? freq[k] : wordFreq[k];
        }
    }

    int count = 0;
    for (int i = 0; i < 26; i++) {
        count += freq[i];
    }

    char **result = (char **)malloc(sizeof(char *) * count + 1);
    *returnSize = 0;

    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < freq[i]; j++) {
            result[*returnSize] = (char *)malloc(sizeof(char) * 2);
            result[*returnSize][0] = 'a' + i;
            result[*returnSize][1] = '\0';
            (*returnSize)++;
        }
    }

    result[*returnSize] = NULL;

    return result;
}