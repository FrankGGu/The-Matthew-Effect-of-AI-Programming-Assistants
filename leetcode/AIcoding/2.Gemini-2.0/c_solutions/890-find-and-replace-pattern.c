#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** findAndReplacePattern(char ** words, int wordsSize, char * pattern, int* returnSize){
    int patternLen = strlen(pattern);
    char ** result = (char **)malloc(sizeof(char *) * wordsSize);
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        char * word = words[i];
        int wordLen = strlen(word);

        if (wordLen != patternLen) {
            continue;
        }

        int wordToPattern[26] = {0};
        int patternToWord[26] = {0};
        int match = 1;

        for (int j = 0; j < patternLen; j++) {
            int wordChar = word[j] - 'a';
            int patternChar = pattern[j] - 'a';

            if (wordToPattern[wordChar] == 0 && patternToWord[patternChar] == 0) {
                wordToPattern[wordChar] = patternChar + 1;
                patternToWord[patternChar] = wordChar + 1;
            } else if (wordToPattern[wordChar] != patternChar + 1 || patternToWord[patternChar] != wordChar + 1) {
                match = 0;
                break;
            }
        }

        if (match) {
            result[*returnSize] = (char *)malloc(sizeof(char) * (wordLen + 1));
            strcpy(result[*returnSize], word);
            (*returnSize)++;
        }
    }

    return result;
}