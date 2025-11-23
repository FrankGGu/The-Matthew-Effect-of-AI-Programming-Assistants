#include <stdbool.h>
#include <string.h>
#include <ctype.h>

bool is_valid_punctuation(char c) {
    return c == '!' || c == '.' || c == ',';
}

bool is_valid_word(const char* word) {
    int len = strlen(word);
    if (len == 0) {
        return false;
    }

    int hyphen_count = 0;
    int punctuation_count = 0;

    for (int i = 0; i < len; i++) {
        char c = word[i];

        if (isdigit(c)) {
            return false;
        }

        if (c == '-') {
            hyphen_count++;
            if (hyphen_count > 1) {
                return false;
            }
            if (i == 0 || i == len - 1 || !islower(word[i-1]) || !islower(word[i+1])) {
                return false;
            }
        } else if (is_valid_punctuation(c)) {
            punctuation_count++;
            if (punctuation_count > 1) {
                return false;
            }
            if (i != len - 1) {
                return false;
            }
        } else if (!islower(c)) {
            return false;
        }
    }
    return true;
}

int countValidWords(char* sentence) {
    int valid_words_count = 0;
    int n = strlen(sentence);
    int i = 0;

    while (i < n) {
        while (i < n && sentence[i] == ' ') {
            i++;
        }
        if (i == n) {
            break;
        }

        int start = i;
        while (i < n && sentence[i] != ' ') {
            i++;
        }
        int end = i - 1;

        char word_buffer[end - start + 2];
        strncpy(word_buffer, sentence + start, end - start + 1);
        word_buffer[end - start + 1] = '\0';

        if (is_valid_word(word_buffer)) {
            valid_words_count++;
        }
    }

    return valid_words_count;
}