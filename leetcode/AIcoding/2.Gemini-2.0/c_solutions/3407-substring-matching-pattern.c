#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool wordPattern(char * pattern, char * s){
    char *words[26] = {NULL};
    char *pattern_to_word[256] = {NULL};
    int pattern_len = strlen(pattern);
    char *token = strtok(s, " ");
    int i = 0;

    while (token != NULL) {
        if (i >= pattern_len) return false;

        char c = pattern[i];

        if (pattern_to_word[(unsigned char)c] == NULL) {
            bool word_used = false;
            for (int j = 0; j < 26; j++) {
                if (words[j] != NULL && strcmp(words[j], token) == 0) {
                    word_used = true;
                    break;
                }
            }
            if (word_used) return false;

            pattern_to_word[(unsigned char)c] = token;
            for (int j = 0; j < 26; j++) {
                if (words[j] == NULL) {
                    words[j] = token;
                    break;
                }
            }
        } else {
            if (strcmp(pattern_to_word[(unsigned char)c], token) != 0) {
                return false;
            }
        }

        token = strtok(NULL, " ");
        i++;
    }

    if (i != pattern_len) return false;

    return true;
}