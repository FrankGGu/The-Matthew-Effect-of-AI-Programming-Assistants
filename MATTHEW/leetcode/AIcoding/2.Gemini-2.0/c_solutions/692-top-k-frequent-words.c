#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *word;
    int count;
} WordCount;

int compare(const void *a, const void *b) {
    WordCount *wc1 = (WordCount *)a;
    WordCount *wc2 = (WordCount *)b;
    if (wc1->count != wc2->count) {
        return wc2->count - wc1->count;
    } else {
        return strcmp(wc1->word, wc2->word);
    }
}

char **topKFrequent(char **words, int wordsSize, int k, int *returnSize) {
    WordCount *wordCounts = (WordCount *)malloc(wordsSize * sizeof(WordCount));
    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        int found = 0;
        for (int j = 0; j < count; j++) {
            if (strcmp(wordCounts[j].word, words[i]) == 0) {
                wordCounts[j].count++;
                found = 1;
                break;
            }
        }
        if (!found) {
            wordCounts[count].word = words[i];
            wordCounts[count].count = 1;
            count++;
        }
    }

    qsort(wordCounts, count, sizeof(WordCount), compare);

    char **result = (char **)malloc(k * sizeof(char *));
    for (int i = 0; i < k; i++) {
        result[i] = wordCounts[i].word;
    }

    *returnSize = k;
    free(wordCounts);
    return result;
}