#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *key;
    int count;
} Pair;

int compare(const void *a, const void *b) {
    Pair *p1 = (Pair *)a;
    Pair *p2 = (Pair *)b;
    return p2->count - p1->count;
}

int maxOccurrences(char *s, char **parts, int partsSize) {
    int len = strlen(s);
    int *prefix = (int *)malloc((len + 1) * sizeof(int));
    int *suffix = (int *)malloc((len + 1) * sizeof(int));
    int *lps = (int *)malloc(len * sizeof(int));
    int maxCount = 0;
    int *counts = (int *)calloc(partsSize, sizeof(int));

    for (int i = 0; i < partsSize; i++) {
        int partLen = strlen(parts[i]);
        if (partLen == 0) continue;
        int *tempLPS = (int *)malloc(partLen * sizeof(int));
        int j = 0;
        for (int k = 1; k < partLen; k++) {
            while (j > 0 && parts[i][k] != parts[i][j]) {
                j = tempLPS[j - 1];
            }
            if (parts[i][k] == parts[i][j]) {
                j++;
                tempLPS[k] = j;
            } else {
                tempLPS[k] = 0;
            }
        }

        j = 0;
        for (int k = 0; k < len; k++) {
            while (j > 0 && s[k] != parts[i][j]) {
                j = tempLPS[j - 1];
            }
            if (s[k] == parts[i][j]) {
                j++;
            }
            if (j == partLen) {
                counts[i]++;
                j = tempLPS[j - 1];
            }
        }
        free(tempLPS);
    }

    int max = 0;
    for (int i = 0; i < partsSize; i++) {
        if (counts[i] > max) {
            max = counts[i];
        }
    }

    free(prefix);
    free(suffix);
    free(lps);
    free(counts);

    return max;
}