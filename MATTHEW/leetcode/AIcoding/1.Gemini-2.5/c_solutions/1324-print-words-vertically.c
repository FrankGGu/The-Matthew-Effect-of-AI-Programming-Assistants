#include <stdlib.h>
#include <string.h>

char** printVertically(char* s, int* returnSize) {
    int num_words = 0;
    int max_len = 0;
    int current_word_len = 0;

    int s_len = strlen(s);

    for (int i = 0; i < s_len; i++) {
        if (s[i] == ' ') {
            num_words++;
            if (current_word_len > max_len) {
                max_len = current_word_len;
            }
            current_word_len = 0;
        } else {
            current_word_len++;
        }
    }
    num_words++;
    if (current_word_len > max_len) {
        max_len = current_word_len;
    }

    char** words_arr = (char**)malloc(num_words * sizeof(char*));

    int word_idx = 0;
    int start_idx = 0;
    for (int i = 0; i < s_len; i++) {
        if (s[i] == ' ') {
            int len = i - start_idx;
            words_arr[word_idx] = (char*)malloc((len + 1) * sizeof(char));
            strncpy(words_arr[word_idx], s + start_idx, len);
            words_arr[word_idx][len] = '\0';
            word_idx++;
            start_idx = i + 1;
        }
    }
    int len = s_len - start_idx;
    words_arr[word_idx] = (char*)malloc((len + 1) * sizeof(char));
    strncpy(words_arr[word_idx], s + start_idx, len);
    words_arr[word_idx][len] = '\0';

    char** result = (char**)malloc(max_len * sizeof(char*));
    *returnSize = max_len;

    for (int r = 0; r < max_len; r++) {
        char* current_column_buffer = (char*)malloc((num_words + 1) * sizeof(char));
        int current_col_len = 0;

        for (int c = 0; c < num_words; c++) {
            if (r < strlen(words_arr[c])) {
                current_column_buffer[current_col_len++] = words_arr[c][r];
            } else {
                current_column_buffer[current_col_len++] = ' ';
            }
        }
        current_column_buffer[current_col_len] = '\0';

        while (current_col_len > 0 && current_column_buffer[current_col_len - 1] == ' ') {
            current_col_len--;
        }
        current_column_buffer[current_col_len] = '\0';

        result[r] = (char*)malloc((current_col_len + 1) * sizeof(char));
        strcpy(result[r], current_column_buffer);
        free(current_column_buffer);
    }

    for (int j = 0; j < num_words; j++) {
        free(words_arr[j]);
    }
    free(words_arr);

    return result;
}