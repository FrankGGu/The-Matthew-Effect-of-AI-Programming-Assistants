#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

bool matches(char* word, char* pattern) {
    int pattern_to_word[26] = {0};
    int word_to_pattern[26] = {0};

    int len = strlen(pattern);
    for (int i = 0; i < len; i++) {
        int p_char_idx = pattern[i] - 'a';
        int w_char_idx = word[i] - 'a';

        if (pattern_to_word[p_char_idx] == 0) {
            pattern_to_word[p_char_idx] = w_char_idx + 1;
        } else {
            if (pattern_to_word[p_char_idx] != w_char_idx + 1) {
                return false;
            }
        }

        if (word_to_pattern[w_char_idx] == 0) {
            word_to_pattern[w_char_idx] = p_char_idx + 1;
        } else {
            if (word_to_pattern[w_char_idx] != p_char_idx + 1) {
                return false;
            }
        }
    }
    return true;
}

char ** findAndReplacePattern(char ** words, int wordsSize, char * pattern, int* returnSize) {
    char **result = (char **)malloc(wordsSize * sizeof(char *));
    int result_count = 0;

    for (int i = 0; i < wordsSize; i++) {
        if (matches(words[i], pattern)) {
            result[result_count] = words[i];
            result_count++;
        }
    }

    *returnSize = result_count;
    return result;
}