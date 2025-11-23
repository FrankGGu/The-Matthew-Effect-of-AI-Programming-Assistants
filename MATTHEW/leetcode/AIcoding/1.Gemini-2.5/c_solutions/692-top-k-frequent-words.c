#include <stdlib.h>
#include <string.h>

typedef struct {
    char* word;
    int freq;
} WordFreq;

int compare_strings(const void* a, const void* b) {
    return strcmp(*(char* const*)a, *(char* const*)b);
}

int compare_word_freqs(const void* a, const void* b) {
    WordFreq* wf1 = (WordFreq*)a;
    WordFreq* wf2 = (WordFreq*)b;

    if (wf1->freq != wf2->freq) {
        return wf2->freq - wf1->freq;
    } else {
        return strcmp(wf1->word, wf2->word);
    }
}

char** topKFrequent(char** words, int wordsSize, int k, int* returnSize) {
    if (wordsSize == 0 || k == 0) {
        *returnSize = 0;
        return NULL;
    }

    qsort(words, wordsSize, sizeof(char*), compare_strings);

    WordFreq* freq_array = (WordFreq*)malloc(wordsSize * sizeof(WordFreq));
    if (freq_array == NULL) {
        *returnSize = 0;
        return NULL;
    }
    int unique_word_count = 0;

    int i = 0;
    while (i < wordsSize) {
        char* current_word = words[i];
        int current_freq = 0;
        int j = i;
        while (j < wordsSize && strcmp(words[j], current_word) == 0) {
            current_freq++;
            j++;
        }

        freq_array[unique_word_count].word = current_word;
        freq_array[unique_word_count].freq = current_freq;
        unique_word_count++;

        i = j;
    }

    qsort(freq_array, unique_word_count, sizeof(WordFreq), compare_word_freqs);

    char** result = (char**)malloc(k * sizeof(char*));
    if (result == NULL) {
        free(freq_array);
        *returnSize = 0;
        return NULL;
    }

    for (int idx = 0; idx < k; idx++) {
        result[idx] = strdup(freq_array[idx].word);
        if (result[idx] == NULL) {
            for (int j = 0; j < idx; j++) {
                free(result[j]);
            }
            free(result);
            free(freq_array);
            *returnSize = 0;
            return NULL;
        }
    }

    *returnSize = k;
    free(freq_array);

    return result;
}