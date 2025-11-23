#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool wordPattern(char* pattern, char* s) {
    int pLen = strlen(pattern);
    int sLen = strlen(s);

    char* words[1000];
    int wordCount = 0;
    char* token = strtok(s, " ");
    while (token != NULL) {
        words[wordCount++] = token;
        token = strtok(NULL, " ");
    }

    if (pLen != wordCount) return false;

    char* mapP[256] = {NULL};
    char* mapS[1000] = {NULL};

    for (int i = 0; i < pLen; i++) {
        char c = pattern[i];
        char* word = words[i];

        if (mapP[c] == NULL && mapS[word] == NULL) {
            mapP[c] = word;
            mapS[word] = &c;
        } else {
            if (mapP[c] != word || mapS[word] != &c) {
                return false;
            }
        }
    }

    return true;
}