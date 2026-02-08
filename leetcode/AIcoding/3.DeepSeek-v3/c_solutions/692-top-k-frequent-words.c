/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

typedef struct {
    char* word;
    int count;
} WordCount;

int compare(const void* a, const void* b) {
    WordCount* wc1 = (WordCount*)a;
    WordCount* wc2 = (WordCount*)b;

    if (wc1->count != wc2->count) {
        return wc2->count - wc1->count;
    }
    return strcmp(wc1->word, wc2->word);
}

char** topKFrequent(char** words, int wordsSize, int k, int* returnSize) {
    WordCount* wordCounts = malloc(wordsSize * sizeof(WordCount));
    int uniqueCount = 0;

    for (int i = 0; i < wordsSize; i++) {
        int found = 0;
        for (int j = 0; j < uniqueCount; j++) {
            if (strcmp(wordCounts[j].word, words[i]) == 0) {
                wordCounts[j].count++;
                found = 1;
                break;
            }
        }
        if (!found) {
            wordCounts[uniqueCount].word = words[i];
            wordCounts[uniqueCount].count = 1;
            uniqueCount++;
        }
    }

    qsort(wordCounts, uniqueCount, sizeof(WordCount), compare);

    char** result = malloc(k * sizeof(char*));
    for (int i = 0; i < k; i++) {
        result[i] = wordCounts[i].word;
    }

    *returnSize = k;
    free(wordCounts);
    return result;
}