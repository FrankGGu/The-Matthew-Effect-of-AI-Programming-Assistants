#include <stdlib.h>
#include <string.h>

char *g_result_string;
int g_k_target;
int g_current_count;
int g_n_len;

void backtrack(char *current_string_buffer, int current_length, char last_char) {
    if (g_result_string != NULL) {
        return;
    }

    if (current_length == g_n_len) {
        g_current_count++;
        if (g_current_count == g_k_target) {
            current_string_buffer[current_length] = '\0';
            g_result_string = (char *)malloc((g_n_len + 1) * sizeof(char));
            if (g_result_string == NULL) {
                return;
            }
            strcpy(g_result_string, current_string_buffer);
        }
        return;
    }

    char next_chars[] = {'a', 'b', 'c'};
    for (int i = 0; i < 3; i++) {
        char next_char = next_chars[i];
        if (next_char != last_char) {
            current_string_buffer[current_length] = next_char;
            backtrack(current_string_buffer, current_length + 1, next_char);
            if (g_result_string != NULL) {
                return;
            }
        }
    }
}

char *getHappyString(int n, int k) {
    g_n_len = n;
    g_k_target = k;
    g_current_count = 0;
    g_result_string = NULL;

    char *current_string_buffer = (char *)malloc((n + 1) * sizeof(char));
    if (current_string_buffer == NULL) {
        char *empty_str = (char *)malloc(1);
        if (empty_str) *empty_str = '\0';
        return empty_str;
    }

    char start_chars[] = {'a', 'b', 'c'};
    for (int i = 0; i < 3; i++) {
        current_string_buffer[0] = start_chars[i];
        backtrack(current_string_buffer, 1, start_chars[i]);
        if (g_result_string != NULL) {
            break;
        }
    }

    free(current_string_buffer);

    if (g_result_string == NULL) {
        char *empty_str = (char *)malloc(1);
        if (empty_str) *empty_str = '\0';
        return empty_str;
    } else {
        return g_result_string;
    }
}