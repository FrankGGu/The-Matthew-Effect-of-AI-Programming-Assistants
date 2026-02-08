#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findNumOfValidWords(char** words, int wordsSize, char** puzzles, int puzzlesSize, int* returnSize) {
    int* result = (int*)malloc(puzzlesSize * sizeof(int));
    *returnSize = puzzlesSize;

    int* wordMasks = (int*)malloc(wordsSize * sizeof(int));
    for (int i = 0; i < wordsSize; i++) {
        int mask = 0;
        for (int j = 0; words[i][j] != '\0'; j++) {
            mask |= (1 << (words[i][j] - 'a'));
        }
        wordMasks[i] = mask;
    }

    for (int i = 0; i < puzzlesSize; i++) {
        int count = 0;
        int firstCharMask = 1 << (puzzles[i][0] - 'a');
        int puzzleMask = 0;
        for (int j = 0; puzzles[i][j] != '\0'; j++) {
            puzzleMask |= (1 << (puzzles[i][j] - 'a'));
        }

        for (int j = 0; j < wordsSize; j++) {
            if ((wordMasks[j] & firstCharMask) && ((wordMasks[j] & puzzleMask) == wordMasks[j])) {
                count++;
            }
        }
        result[i] = count;
    }

    free(wordMasks);
    return result;
}