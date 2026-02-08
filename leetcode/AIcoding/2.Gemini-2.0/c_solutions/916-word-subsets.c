#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORD_LENGTH 10

char **wordSubsets(char **words1, int words1Size, char **words2, int words2Size, int *returnSize) {
    int max_freq[26] = {0};

    for (int i = 0; i < words2Size; i++) {
        int freq[26] = {0};
        for (int j = 0; words2[i][j] != '\0'; j++) {
            freq[words2[i][j] - 'a']++;
        }
        for (int k = 0; k < 26; k++) {
            if (freq[k] > max_freq[k]) {
                max_freq[k] = freq[k];
            }
        }
    }

    char **result = (char **)malloc(words1Size * sizeof(char *));
    *returnSize = 0;

    for (int i = 0; i < words1Size; i++) {
        int freq[26] = {0};
        for (int j = 0; words1[i][j] != '\0'; j++) {
            freq[words1[i][j] - 'a']++;
        }

        int is_subset = 1;
        for (int k = 0; k < 26; k++) {
            if (freq[k] < max_freq[k]) {
                is_subset = 0;
                break;
            }
        }

        if (is_subset) {
            result[*returnSize] = strdup(words1[i]);
            (*returnSize)++;
        }
    }

    return result;
}