#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* word;
    int mask;
} WordEntry;

int compare(const void* a, const void* b) {
    return ((WordEntry*)b)->mask - ((WordEntry*)a)->mask;
}

int countValidWords(char** words, int wordsSize, char** puzzles, int puzzlesSize) {
    int* result = (int*)malloc(puzzlesSize * sizeof(int));
    int* wordMasks = (int*)malloc(wordsSize * sizeof(int));
    int wordCount = 0;

    for (int i = 0; i < wordsSize; ++i) {
        int mask = 0;
        for (int j = 0; j < strlen(words[i]); ++j) {
            mask |= 1 << (words[i][j] - 'a');
        }
        wordMasks[wordCount++] = mask;
    }

    qsort(wordMasks, wordCount, sizeof(int), compare);

    for (int p = 0; p < puzzlesSize; ++p) {
        char* puzzle = puzzles[p];
        int puzzleMask = 0;
        for (int j = 0; j < strlen(puzzle); ++j) {
            puzzleMask |= 1 << (puzzle[j] - 'a');
        }
        int firstChar = 1 << (puzzle[0] - 'a');
        int count = 0;

        for (int i = 0; i < wordCount; ++i) {
            if ((wordMasks[i] & firstChar) && (wordMasks[i] & puzzleMask) == wordMasks[i]) {
                ++count;
            }
        }

        result[p] = count;
    }

    return result;
}