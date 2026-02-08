#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return strcmp(*(const char **)a, *(const char **)b);
}

char *longestWord(char **words, int wordsSize) {
    qsort(words, wordsSize, sizeof(char *), cmp);
    char *longest = "";
    int len = 0;
    int *dp = (int *)calloc(wordsSize, sizeof(int));

    for (int i = 0; i < wordsSize; i++) {
        if (words[i][0] == '\0' || (i > 0 && strcmp(words[i], words[i - 1]) == 0)) {
            continue;
        }
        int valid = 1;
        for (int j = 1; j < strlen(words[i]); j++) {
            char temp = words[i][j];
            words[i][j] = '\0';
            valid = 0;
            for (int k = 0; k < wordsSize; k++) {
                if (strcmp(words[k], words[i]) == 0) {
                    valid = 1;
                    break;
                }
            }
            words[i][j] = temp;
            if (!valid) break;
        }
        if (valid && strlen(words[i]) > len) {
            len = strlen(words[i]);
            longest = words[i];
        }
    }
    free(dp);
    return longest;
}