#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* word;
    int count;
} WordCount;

int compare(const void* a, const void* b) {
    WordCount* wa = (WordCount*)a;
    WordCount* wb = (WordCount*)b;
    if (wa->count != wb->count) {
        return wb->count - wa->count;
    }
    return strcmp(wa->word, wb->word);
}

char** topKFrequent(char** words, int wordsSize, int k, int* returnSize) {
    WordCount* counts = (WordCount*)malloc(sizeof(WordCount) * wordsSize);
    int countSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        int found = 0;
        for (int j = 0; j < countSize; j++) {
            if (strcmp(counts[j].word, words[i]) == 0) {
                counts[j].count++;
                found = 1;
                break;
            }
        }
        if (!found) {
            counts[countSize].word = strdup(words[i]);
            counts[countSize].count = 1;
            countSize++;
        }
    }

    qsort(counts, countSize, sizeof(WordCount), compare);

    char** result = (char**)malloc(sizeof(char*) * k);
    for (int i = 0; i < k; i++) {
        result[i] = strdup(counts[i].word);
    }

    *returnSize = k;
    free(counts);
    return result;
}