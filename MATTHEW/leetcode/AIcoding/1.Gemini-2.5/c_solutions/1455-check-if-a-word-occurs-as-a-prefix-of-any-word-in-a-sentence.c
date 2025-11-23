#include <string.h>

int isPrefixOfWord(char * sentence, char * searchWord) {
    int word_count = 0;
    size_t search_len = strlen(searchWord);
    char *current_word_start = sentence;

    while (*current_word_start != '\0') {
        while (*current_word_start == ' ') {
            current_word_start++;
        }

        if (*current_word_start == '\0') {
            break;
        }

        word_count++;

        char *temp_ptr = current_word_start;
        size_t current_word_len = 0;
        while (*temp_ptr != ' ' && *temp_ptr != '\0') {
            current_word_len++;
            temp_ptr++;
        }

        if (current_word_len >= search_len && strncmp(current_word_start, searchWord, search_len) == 0) {
            return word_count;
        }

        current_word_start = temp_ptr;
    }

    return -1;
}