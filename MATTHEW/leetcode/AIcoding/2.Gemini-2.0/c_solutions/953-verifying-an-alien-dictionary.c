#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isAlienSorted(char ** words, int wordsSize, char * order){
    int orderMap[26];
    for (int i = 0; i < 26; i++) {
        orderMap[order[i] - 'a'] = i;
    }

    for (int i = 0; i < wordsSize - 1; i++) {
        char *word1 = words[i];
        char *word2 = words[i + 1];
        int j = 0;
        while (word1[j] != '\0' && word2[j] != '\0') {
            if (orderMap[word1[j] - 'a'] < orderMap[word2[j] - 'a']) {
                break;
            } else if (orderMap[word1[j] - 'a'] > orderMap[word2[j] - 'a']) {
                return false;
            }
            j++;
        }
        if (word1[j] != '\0' && word2[j] == '\0') {
            return false;
        }
    }
    return true;
}