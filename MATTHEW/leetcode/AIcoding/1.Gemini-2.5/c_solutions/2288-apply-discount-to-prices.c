#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char *applyDiscount(char *sentence, int discount) {
    int sentence_len = strlen(sentence);
    char *result = (char *)malloc(sizeof(char) * (sentence_len * 3 + 100));
    if (result == NULL) {
        return NULL;
    }
    result[0] = '\0';

    char *current_pos = sentence;
    int result_idx = 0;

    while (*current_pos != '\0') {
        while (*current_pos == ' ') {
            result[result_idx++] = *current_pos;
            current_pos++;
        }

        if (*current_pos == '\0') {
            break;
        }

        char *word_start = current_pos;

        while (*current_pos != ' ' && *current_pos != '\0') {
            current_pos++;
        }

        int word_len = current_pos - word_start;

        int is_price = 0;
        if (word_len > 1 && word_start[0] == '$') {
            is_price = 1;
            for (int i = 1; i < word_len; i++) {
                if (!isdigit(word_start[i])) {
                    is_price = 0;
                    break;
                }
            }
        }

        if (is_price) {
            long long original_price_val = atoll(word_start + 1);
            double discounted_price_val = (double)original_price_val * (100 - discount) / 100.0;

            result_idx += snprintf(result + result_idx, (sentence_len * 3 + 100) - result_idx, "$%.2f", discounted_price_val);
        } else {
            strncpy(result + result_idx, word_start, word_len);
            result_idx += word_len;
        }
    }
    result[result_idx] = '\0';

    return result;
}