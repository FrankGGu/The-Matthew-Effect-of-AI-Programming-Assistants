#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_WORD_LENGTH 7
#define MAX_PUZZLE_LENGTH 7
#define MAX_WORDS 10000

typedef struct {
    int mask;
    int count;
} Word;

int bitmask(char *word) {
    int mask = 0;
    for (int i = 0; word[i]; i++) {
        mask |= 1 << (word[i] - 'a');
    }
    return mask;
}

int can_form(int word_mask, int puzzle_mask, int first_letter_mask) {
    return (word_mask & puzzle_mask) == word_mask && (word_mask & first_letter_mask) != 0;
}

int* findNumOfValidWords(char **words, int wordsSize, char **puzzles, int puzzlesSize, int* returnSize) {
    Word *wordList = (Word *)malloc(sizeof(Word) * wordsSize);
    int *result = (int *)malloc(sizeof(int) * puzzlesSize);
    int first_letter_mask, puzzle_mask;

    for (int i = 0; i < wordsSize; i++) {
        wordList[i].mask = bitmask(words[i]);
        wordList[i].count = 1;
    }

    *returnSize = puzzlesSize;

    for (int i = 0; i < puzzlesSize; i++) {
        puzzle_mask = bitmask(puzzles[i]);
        first_letter_mask = 1 << (puzzles[i][0] - 'a');
        result[i] = 0;

        for (int j = 0; j < wordsSize; j++) {
            if (can_form(wordList[j].mask, puzzle_mask, first_letter_mask)) {
                result[i] += wordList[j].count;
            }
        }
    }

    free(wordList);
    return result;
}