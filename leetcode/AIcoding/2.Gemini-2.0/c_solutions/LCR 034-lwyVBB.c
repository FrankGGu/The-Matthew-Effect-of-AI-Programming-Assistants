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
        int len1 = strlen(word1);
        int len2 = strlen(word2);
        int j = 0;
        while (j < len1 && j < len2) {
            if (orderMap[word1[j] - 'a'] < orderMap[word2[j] - 'a']) {
                break;
            } else if (orderMap[word1[j] - 'a'] > orderMap[word2[j] - 'a']) {
                return false;
            }
            j++;
        }
        if (j == len2 && j < len1) {
            return false;
        }
    }

    return true;
}