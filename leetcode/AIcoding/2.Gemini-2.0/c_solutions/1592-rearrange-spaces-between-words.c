#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *rearrangeSpaces(char *text) {
    int spaces = 0;
    int words = 0;
    int len = strlen(text);
    char *result = (char *)malloc(len + 1);
    int word_start = -1;
    char **word_array = (char **)malloc(len * sizeof(char *));
    int word_count = 0;

    for (int i = 0; i < len; i++) {
        if (text[i] == ' ') {
            spaces++;
            if (word_start != -1) {
                char *word = (char *)malloc(i - word_start + 1);
                strncpy(word, text + word_start, i - word_start);
                word[i - word_start] = '\0';
                word_array[word_count++] = word;
                words++;
                word_start = -1;
            }
        } else {
            if (word_start == -1) {
                word_start = i;
            }
        }
    }

    if (word_start != -1) {
        char *word = (char *)malloc(len - word_start + 1);
        strncpy(word, text + word_start, len - word_start);
        word[len - word_start] = '\0';
        word_array[word_count++] = word;
        words++;
    }

    if (words == 0) {
        memset(result, ' ', len);
        result[len] = '\0';
        return result;
    }

    int spaces_between = (words == 1) ? 0 : spaces / (words - 1);
    int extra_spaces = (words == 1) ? spaces : spaces % (words - 1);

    int result_index = 0;
    for (int i = 0; i < words; i++) {
        char *word = word_array[i];
        int word_len = strlen(word);
        strncpy(result + result_index, word, word_len);
        result_index += word_len;

        if (i < words - 1) {
            for (int j = 0; j < spaces_between; j++) {
                result[result_index++] = ' ';
            }
        }
        free(word);
    }

    for (int i = 0; i < extra_spaces; i++) {
        result[result_index++] = ' ';
    }

    result[result_index] = '\0';
    free(word_array);
    return result;
}