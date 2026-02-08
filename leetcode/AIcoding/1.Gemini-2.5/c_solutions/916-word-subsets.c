#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

static void get_char_freq(char *word, int *freq_array) {
    for (int i = 0; i < 26; i++) {
        freq_array[i] = 0;
    }
    for (int i = 0; word[i] != '\0'; i++) {
        freq_array[word[i] - 'a']++;
    }
}

char **wordSubsets(char **words1, int words1Size, char **words2, int words2Size, int *returnSize) {
    int max_freq_b[26];
    for (int i = 0; i < 26; i++) {
        max_freq_b[i] = 0;
    }

    int current_freq_b[26];

    for (int i = 0; i < words2Size; i++) {
        get_char_freq(words2[i], current_freq_b);
        for (int j = 0; j < 26; j++) {
            if (current_freq_b[j] > max_freq_b[j]) {
                max_freq_b[j] = current_freq_b[j];
            }
        }
    }

    char **result = NULL;
    *returnSize = 0;
    int result_capacity = 0;

    int freq_a[26];

    for (int i = 0; i < words1Size; i++) {
        get_char_freq(words1[i], freq_a);

        bool is_universal = true;
        for (int j = 0; j < 26; j++) {
            if (freq_a[j] < max_freq_b[j]) {
                is_universal = false;
                break;
            }
        }

        if (is_universal) {
            if (*returnSize == result_capacity) {
                result_capacity = (result_capacity == 0) ? 1 : result_capacity * 2;
                result = (char **)realloc(result, result_capacity * sizeof(char *));
            }
            result[*returnSize] = (char *)malloc((strlen(words1[i]) + 1) * sizeof(char));
            strcpy(result[*returnSize], words1[i]);
            (*returnSize)++;
        }
    }

    return result;
}