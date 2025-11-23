#include <stdbool.h>
#include <string.h>

bool isPrefixString(char * s, char ** words, int wordsSize){
    int s_len = strlen(s);
    int current_len = 0;

    for (int i = 0; i < wordsSize; i++) {
        int word_len = strlen(words[i]);
        if (current_len + word_len > s_len) {
            return false;
        }

        if (strncmp(s + current_len, words[i], word_len) != 0) {
            return false;
        }

        current_len += word_len;

        if (current_len == s_len) {
            return true;
        }
    }

    return false;
}