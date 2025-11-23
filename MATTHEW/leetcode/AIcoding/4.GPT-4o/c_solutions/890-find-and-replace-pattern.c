#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** findAndReplacePattern(char** words, int wordsSize, char* pattern, int* returnSize) {
    char** result = (char**)malloc(wordsSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        char map1[26] = {0}, map2[26] = {0};
        int j;
        for (j = 0; words[i][j] && pattern[j]; j++) {
            if (map1[pattern[j] - 'a'] == 0 && map2[words[i][j] - 'a'] == 0) {
                map1[pattern[j] - 'a'] = words[i][j];
                map2[words[i][j] - 'a'] = pattern[j];
            } else if (map1[pattern[j] - 'a'] != words[i][j] || map2[words[i][j] - 'a'] != pattern[j]) {
                break;
            }
        }
        if (words[i][j] == '\0' && pattern[j] == '\0') {
            result[(*returnSize)++] = strdup(words[i]);
        }
    }

    return result;
}