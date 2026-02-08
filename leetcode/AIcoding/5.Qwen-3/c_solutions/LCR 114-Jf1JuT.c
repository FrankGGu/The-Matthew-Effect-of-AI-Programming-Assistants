#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    char *s1 = *(char **)a;
    char *s2 = *(char **)b;
    int i = 0;
    while (s1[i] && s2[i]) {
        if (s1[i] != s2[i]) {
            return s1[i] - s2[i];
        }
        i++;
    }
    return strlen(s1) - strlen(s2);
}

int alienCompare(char a, char b, char *order) {
    for (int i = 0; i < strlen(order); i++) {
        if (order[i] == a) return -1;
        if (order[i] == b) return 1;
    }
    return 0;
}

bool isAlienSorted(char **words, int wordsSize, char *order) {
    char **sorted = (char **)malloc(wordsSize * sizeof(char *));
    for (int i = 0; i < wordsSize; i++) {
        sorted[i] = strdup(words[i]);
    }
    qsort(sorted, wordsSize, sizeof(char *), compare);
    for (int i = 0; i < wordsSize - 1; i++) {
        int j = 0;
        while (sorted[i][j] && sorted[i+1][j]) {
            if (sorted[i][j] != sorted[i+1][j]) {
                if (alienCompare(sorted[i][j], sorted[i+1][j], order) > 0) {
                    free(sorted);
                    return false;
                }
                break;
            }
            j++;
        }
    }
    free(sorted);
    return true;
}