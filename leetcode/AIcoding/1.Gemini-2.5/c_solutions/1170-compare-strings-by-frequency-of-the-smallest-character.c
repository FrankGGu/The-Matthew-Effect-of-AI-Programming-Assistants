#include <stdlib.h> 

int calculate_f(char *s) {
    char min_char = 'z' + 1; 
    int count = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] < min_char) {
            min_char = s[i];
            count = 1;
        } else if (s[i] == min_char) {
            count++;
        }
    }
    return count;
}

int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* numSmallerByFrequency(char **queries, int queriesSize, char **words, int wordsSize, int* returnSize) {
    int* word_frequencies = (int*) malloc(wordsSize * sizeof(int));
    for (int i = 0; i < wordsSize; i++) {
        word_frequencies[i] = calculate_f(words[i]);
    }

    qsort(word_frequencies, wordsSize, sizeof(int), compareIntegers);

    int* result = (int*) malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int query_freq = calculate_f(queries[i]);

        int low = 0;
        int high = wordsSize - 1;
        int first_greater_idx = wordsSize; 

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (word_frequencies[mid] > query_freq) {
                first_greater_idx = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        result[i] = wordsSize - first_greater_idx;
    }

    free(word_frequencies);

    return result;
}