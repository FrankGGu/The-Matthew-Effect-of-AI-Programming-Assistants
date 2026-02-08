#include <stdlib.h>
#include <string.h>

static void append_spaces(char* buffer, int* current_len_ptr, int num_spaces) {
    for (int i = 0; i < num_spaces; ++i) {
        buffer[(*current_len_ptr)++] = ' ';
    }
}

char **fullJustify(char **words, int wordsSize, int maxWidth, int *returnSize) {
    char **result = (char **)malloc(wordsSize * sizeof(char *));
    *returnSize = 0;

    int i = 0;
    while (i < wordsSize) {
        int j = i;
        int current_line_words_len = 0;
        int current_line_num_words = 0;

        while (j < wordsSize) {
            int word_len = strlen(words[j]);
            int potential_line_length;

            if (current_line_num_words == 0) {
                potential_line_length = word_len;
            } else {
                potential_line_length = current_line_words_len + current_line_num_words + word_len;
            }

            if (potential_line_length > maxWidth) {
                break;
            }

            current_line_words_len += word_len;
            current_line_num_words++;
            j++;
        }

        char *line_buffer = (char *)malloc((maxWidth + 1) * sizeof(char));
        int buffer_idx = 0;

        int total_spaces_to_distribute = maxWidth - current_line_words_len;

        if (current_line_num_words == 1 || j == wordsSize) {
            for (int k_word = i; k_word < j; ++k_word) {
                strcpy(line_buffer + buffer_idx, words[k_word]);
                buffer_idx += strlen(words[k_word]);

                if (k_word < j - 1) {
                    line_buffer[buffer_idx++] = ' ';
                    total_spaces_to_distribute--;
                }
            }
            append_spaces(line_buffer, &buffer_idx, total_spaces_to_distribute);
        } else {
            int num_gaps = current_line_num_words - 1;
            int base_spaces_per_gap = total_spaces_to_distribute / num_gaps;
            int extra_spaces_for_first_gaps = total_spaces_to_distribute % num_gaps;

            for (int k_word = i; k_word < j; ++k_word) {
                strcpy(line_buffer + buffer_idx, words[k_word]);
                buffer_idx += strlen(words[k_word]);

                if (k_word < j - 1) {
                    int spaces_to_add = base_spaces_per_gap;
                    if (extra_spaces_for_first_gaps > 0) {
                        spaces_to_add++;
                        extra_spaces_for_first_gaps--;
                    }
                    append_spaces(line_buffer, &buffer_idx, spaces_to_add);
                }
            }
        }
        line_buffer[maxWidth] = '\0';

        result[(*returnSize)++] = line_buffer;
        i = j;
    }

    return result;
}