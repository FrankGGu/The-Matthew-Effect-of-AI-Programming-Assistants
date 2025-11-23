#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPrefixString(char * s, char ** words, int wordsSize){
    int s_len = strlen(s);
    int current_len = 0;

    for (int i = 0; i < wordsSize; i++) {
        int word_len = strlen(words[i]);

        if (current_len + word_len <= s_len) {
            char sub[word_len + 1];
            strncpy(sub, s + current_len, word_len);
            sub[word_len] = '\0';

            if (strcmp(sub, words[i]) == 0) {
                current_len += word_len;
                if (current_len == s_len) {
                    return true;
                }
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    return false;
}