#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* word;
    int score;
} WordScore;

int compare(const void* a, const void* b) {
    const WordScore* wsa = (const WordScore*)a;
    const WordScore* wsb = (const WordScore*)b;
    if (wsa->score != wsb->score) {
        return wsa->score - wsb->score;
    }
    return strcmp(wsa->word, wsb->word);
}

char** fuzzyMatch(char** words, int wordsSize, char* pattern, int* returnSize) {
    *returnSize = 0;
    WordScore* results = (WordScore*)malloc(wordsSize * sizeof(WordScore));

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int p = 0;
        int score = 0;
        int match = 1;

        for (int w = 0; word[w]; w++) {
            if (p < strlen(pattern) && word[w] == pattern[p]) {
                p++;
                score += 5;
            } else if (word[w] >= 'A' && word[w] <= 'Z') {
                match = 0;
                break;
            }
        }

        if (p == strlen(pattern)) {
            results[*returnSize].word = strdup(word);
            results[*returnSize].score = score;
            (*returnSize)++;
        }
    }

    qsort(results, *returnSize, sizeof(WordScore), compare);

    char** output = (char**)malloc(*returnSize * sizeof(char*));
    for (int i = 0; i < *returnSize; i++) {
        output[i] = results[i].word;
    }

    free(results);
    return output;
}