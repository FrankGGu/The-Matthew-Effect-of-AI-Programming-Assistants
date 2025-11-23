#include <stdbool.h>
#include <string.h>

bool isAlienSorted(char **words, int wordsSize, char *order) {
    int orderMap[26];
    for (int i = 0; i < 26; i++) {
        orderMap[order[i] - 'a'] = i;
    }

    for (int i = 1; i < wordsSize; i++) {
        int len1 = strlen(words[i - 1]);
        int len2 = strlen(words[i]);
        int minLen = len1 < len2 ? len1 : len2;
        int cmp = 0;

        for (int j = 0; j < minLen; j++) {
            if (words[i - 1][j] != words[i][j]) {
                cmp = orderMap[words[i - 1][j] - 'a'] - orderMap[words[i][j] - 'a'];
                break;
            }
        }

        if (cmp == 0 && len1 > len2) {
            return false;
        }
        if (cmp < 0) continue;
        if (cmp > 0) return false;
    }

    return true;
}