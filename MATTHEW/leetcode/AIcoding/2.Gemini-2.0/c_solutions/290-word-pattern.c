#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool wordPattern(char * pattern, char * s){
    int pattern_len = strlen(pattern);
    char *words[pattern_len];
    int words_len = 0;
    char *token = strtok(s, " ");
    while (token != NULL) {
        words[words_len++] = token;
        token = strtok(NULL, " ");
    }

    if (pattern_len != words_len) {
        return false;
    }

    char *pattern_to_word[26];
    char *word_to_pattern[words_len];
    bool pattern_used[26];
    for (int i = 0; i < 26; i++) {
        pattern_to_word[i] = NULL;
        pattern_used[i] = false;
    }
    for (int i = 0; i < words_len; i++) {
        word_to_pattern[i] = NULL;
    }

    for (int i = 0; i < pattern_len; i++) {
        int pattern_index = pattern[i] - 'a';
        if (pattern_to_word[pattern_index] == NULL && word_to_pattern[i] == NULL) {
            pattern_to_word[pattern_index] = words[i];
            word_to_pattern[i] = pattern + i;
        } else if (pattern_to_word[pattern_index] == NULL || word_to_pattern[i] == NULL) {
            return false;
        } else {
            if (strcmp(pattern_to_word[pattern_index], words[i]) != 0) {
                return false;
            }

            bool found = false;
            for (int j = 0; j < i; j++) {
                if (word_to_pattern[j] == pattern + i) {
                    found = true;
                    break;
                }
            }
            if (!found && word_to_pattern[i] != pattern+i)
            {
                return false;
            }
        }
    }

    char *reverse_pattern_to_word[words_len];
    for (int i = 0; i < words_len; ++i)
    {
        reverse_pattern_to_word[i] = NULL;
    }

    for(int i=0; i<pattern_len; ++i)
    {
        bool found = false;
        for(int j=0; j< i; ++j)
        {
            if(strcmp(words[i], words[j]) == 0)
            {
                if(pattern[i] != pattern[j])
                    return false;
                found = true;
                break;
            }
        }

        if(!found)
        {
            for(int k=0; k<i; ++k)
            {
               if(pattern[i] == pattern[k] && strcmp(words[i], words[k]) != 0)
                   return false;
            }
        }
    }

    return true;
}