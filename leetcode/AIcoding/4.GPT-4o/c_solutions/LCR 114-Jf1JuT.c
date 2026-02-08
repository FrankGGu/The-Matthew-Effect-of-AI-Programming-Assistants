#include <stdbool.h>
#include <string.h>

bool isAlienSorted(char **words, int wordsSize, char *order) {
    int orderIndex[26];
    for (int i = 0; i < 26; i++) {
        orderIndex[order[i] - 'a'] = i;
    }

    for (int i = 1; i < wordsSize; i++) {
        int len1 = strlen(words[i - 1]);
        int len2 = strlen(words[i]);
        int minLength = len1 < len2 ? len1 : len2;
        for (int j = 0; j < minLength; j++) {
            if (words[i - 1][j] != words[i][j]) {
                if (orderIndex[words[i - 1][j] - 'a'] > orderIndex[words[i][j] - 'a']) {
                    return false;
                }
                break;
            }
        }
        if (len1 > len2 && strncmp(words[i - 1], words[i], len2) == 0) {
            return false;
        }
    }
    return true;
}