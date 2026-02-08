#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **findAndReplacePattern(char **words, int wordsSize, char *pattern, int *returnSize) {
    char **result = (char **)malloc(wordsSize * sizeof(char *));
    int count = 0;

    int patternLen = strlen(pattern);
    for (int i = 0; i < wordsSize; i++) {
        if (strlen(words[i]) != patternLen) continue;

        int map1[26] = {0}, map2[26] = {0};
        int valid = 1;
        for (int j = 0; j < patternLen; j++) {
            char pChar = pattern[j];
            char wChar = words[i][j];

            if (map1[pChar - 'a'] == 0 && map2[wChar - 'a'] == 0) {
                map1[pChar - 'a'] = wChar;
                map2[wChar - 'a'] = pChar;
            } else if (map1[pChar - 'a'] != wChar || map2[wChar - 'a'] != pChar) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            result[count++] = words[i];
        }
    }

    *returnSize = count;
    return result;
}