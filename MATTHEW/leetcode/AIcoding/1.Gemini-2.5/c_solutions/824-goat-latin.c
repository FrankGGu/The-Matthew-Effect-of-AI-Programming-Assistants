#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>

bool is_vowel(char c) {
    c = tolower(c);
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

char* toGoatLatin(char* sentence) {
    if (sentence == NULL || *sentence == '\0') {
        char* empty_str = (char*)malloc(sizeof(char));
        if (empty_str == NULL) return NULL;
        *empty_str = '\0';
        return empty_str;
    }

    int current_result_capacity = 256;
    char* result = (char*)malloc(current_result_capacity * sizeof(char));
    if (result == NULL) return NULL;
    result[0] = '\0';

    int result_len = 0;
    int word_index = 1;
    char* ptr = sentence;

    while (*ptr != '\0') {
        while (*ptr == ' ') {
            ptr++;
        }
        if (*ptr == '\0') break;

        char* word_start = ptr;
        char* word_end = ptr;
        while (*word_end != ' ' && *word_end != '\0') {
            word_end++;
        }

        int word_length = word_end - word_start;

        char temp_word_buffer[100]; 
        int temp_word_len = 0;

        if (is_vowel(*word_start)) {
            strncpy(temp_word_buffer, word_start, word_length);
            temp_word_len = word_length;
        } else {
            strncpy(temp_word_buffer, word_start + 1, word_length - 1);
            temp_word_len = word_length - 1;
            temp_word_buffer[temp_word_len++] = *word_start;
        }

        temp_word_buffer[temp_word_len++] = 'm';
        temp_word_buffer[temp_word_len++] = 'a';

        for (int i = 0; i < word_index; i++) {
            temp_word_buffer[temp_word_len++] = 'a';
        }
        temp_word_buffer[temp_word_len] = '\0';

        int required_len = result_len + temp_word_len + (result_len > 0 ? 1 : 0);
        while (required_len >= current_result_capacity) {
            current_result_capacity *= 2;
            char* new_result = (char*)realloc(result, current_result_capacity * sizeof(char));
            if (new_result == NULL) {
                free(result);
                return NULL;
            }
            result = new_result;
        }

        if (result_len > 0) {
            result[result_len++] = ' ';
        }

        strcpy(result + result_len, temp_word_buffer);
        result_len += temp_word_len;

        ptr = word_end;
        word_index++;
    }

    char* final_result = (char*)realloc(result, (result_len + 1) * sizeof(char));
    if (final_result == NULL) {
        free(result);
        return NULL;
    }
    return final_result;
}