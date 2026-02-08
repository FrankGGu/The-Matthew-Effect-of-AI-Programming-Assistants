#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char **words;
    int wordSize;
} WordFilter;

WordFilter* wordFilterCreate(char ** words, int wordSize) {
    WordFilter* obj = (WordFilter*)malloc(sizeof(WordFilter));
    obj->words = (char**)malloc(wordSize * sizeof(char*));
    for (int i = 0; i < wordSize; i++) {
        obj->words[i] = (char*)malloc((strlen(words[i]) + 1) * sizeof(char));
        strcpy(obj->words[i], words[i]);
    }
    obj->wordSize = wordSize;
    return obj;
}

int wordFilterF(WordFilter* obj, char * pref, char * suff) {
    int len_pref = strlen(pref);
    int len_suff = strlen(suff);
    for (int i = obj->wordSize - 1; i >= 0; i--) {
        int len_word = strlen(obj->words[i]);
        if (len_pref <= len_word && len_suff <= len_word) {
            int prefix_match = 1;
            for (int j = 0; j < len_pref; j++) {
                if (obj->words[i][j] != pref[j]) {
                    prefix_match = 0;
                    break;
                }
            }
            if (prefix_match) {
                int suffix_match = 1;
                for (int j = 0; j < len_suff; j++) {
                    if (obj->words[i][len_word - len_suff + j] != suff[j]) {
                        suffix_match = 0;
                        break;
                    }
                }
                if (suffix_match) {
                    return i;
                }
            }
        }
    }
    return -1;
}

void wordFilterFree(WordFilter* obj) {
    for (int i = 0; i < obj->wordSize; i++) {
        free(obj->words[i]);
    }
    free(obj->words);
    free(obj);
}