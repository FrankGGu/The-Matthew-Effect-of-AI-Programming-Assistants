#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* word;
    int score;
} WordScore;

int compare(const void* a, const void* b) {
    WordScore* x = (WordScore*)a;
    WordScore* y = (WordScore*)b;
    if (y->score != x->score) return y->score - x->score;
    return strcmp(x->word, y->word);
}

char** topStudents(char** words, int wordsSize, char** puzzles, int puzzlesSize, int k, int* returnSize) {
    WordScore* list = (WordScore*)malloc(wordsSize * sizeof(WordScore));
    for (int i = 0; i < wordsSize; i++) {
        list[i].word = words[i];
        list[i].score = 0;
    }

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int len = strlen(word);
        for (int j = 0; j < len; j++) {
            for (int m = j + 1; m < len; m++) {
                if (word[j] == word[m]) {
                    list[i].score++;
                }
            }
        }
    }

    qsort(list, wordsSize, sizeof(WordScore), compare);

    char** result = (char**)malloc(k * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < wordsSize && *returnSize < k; i++) {
        result[*returnSize] = list[i].word;
        (*returnSize)++;
    }

    free(list);
    return result;
}