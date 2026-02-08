#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORD_LEN 100
#define ALPHABET_SIZE 26

typedef struct {
    int counts[ALPHABET_SIZE];
} WordCount;

int* get_counts(char* word, int* returnSize) {
    int* counts = (int*)calloc(ALPHABET_SIZE, sizeof(int));
    *returnSize = ALPHABET_SIZE;
    for (int i = 0; word[i]; i++) {
        counts[word[i] - 'a']++;
    }
    return counts;
}

int* merge_max_counts(WordCount* max_counts, WordCount* current) {
    int* result = (int*)calloc(ALPHABET_SIZE, sizeof(int));
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        result[i] = (max_counts[i].counts[i] > current->counts[i]) ? max_counts[i].counts[i] : current->counts[i];
    }
    return result;
}

int is_subset(char* word, int* max_counts) {
    int* word_counts = (int*)calloc(ALPHABET_SIZE, sizeof(int));
    for (int i = 0; word[i]; i++) {
        word_counts[word[i] - 'a']++;
    }
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        if (word_counts[i] < max_counts[i]) {
            free(word_counts);
            return 0;
        }
    }
    free(word_counts);
    return 1;
}

char** wordSubsets(char** words1, int words1Size, char** words2, int words2Size, int* returnSize) {
    WordCount* max_counts = (WordCount*)calloc(ALPHABET_SIZE, sizeof(WordCount));
    for (int i = 0; i < words2Size; i++) {
        int word_len = strlen(words2[i]);
        int* current_counts = get_counts(words2[i], &word_len);
        for (int j = 0; j < ALPHABET_SIZE; j++) {
            if (current_counts[j] > max_counts[j].counts[j]) {
                max_counts[j].counts[j] = current_counts[j];
            }
        }
        free(current_counts);
    }

    int* result = (int*)calloc(words1Size, sizeof(int));
    int count = 0;
    for (int i = 0; i < words1Size; i++) {
        if (is_subset(words1[i], max_counts)) {
            result[count++] = i;
        }
    }

    char** output = (char**)malloc(count * sizeof(char*));
    for (int i = 0; i < count; i++) {
        output[i] = strdup(words1[result[i]]);
    }

    *returnSize = count;
    free(result);
    free(max_counts);
    return output;
}