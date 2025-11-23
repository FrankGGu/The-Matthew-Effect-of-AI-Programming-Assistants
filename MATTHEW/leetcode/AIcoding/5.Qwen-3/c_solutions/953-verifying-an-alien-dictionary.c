#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isAlienSorted(char ** words, int wordsSize, char * order) {
    int orderMap[26];
    for (int i = 0; i < strlen(order); i++) {
        orderMap[order[i] - 'a'] = i;
    }

    for (int i = 0; i < wordsSize - 1; i++) {
        char *word1 = words[i];
        char *word2 = words[i + 1];
        int minLen = strlen(word1) < strlen(word2) ? strlen(word1) : strlen(word2);
        for (int j = 0; j < minLen; j++) {
            char c1 = word1[j];
            char c2 = word2[j];
            if (c1 != c2) {
                if (orderMap[c1 - 'a'] > orderMap[c2 - 'a']) {
                    return false;
                }
                break;
            }
        }
    }
    return true;
}