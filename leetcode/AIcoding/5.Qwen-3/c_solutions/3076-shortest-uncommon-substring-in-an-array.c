#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *str;
    int count;
} StringCount;

int compare(const void *a, const void *b) {
    return strcmp(((StringCount *)a)->str, ((StringCount *)b)->str);
}

char* shortestUncommonSubstring(char** s, int n) {
    StringCount *counts = (StringCount *)malloc(n * sizeof(StringCount));
    for (int i = 0; i < n; i++) {
        counts[i].str = s[i];
        counts[i].count = 1;
    }

    qsort(counts, n, sizeof(StringCount), compare);

    for (int i = 0; i < n; i++) {
        if (i > 0 && strcmp(counts[i].str, counts[i - 1].str) == 0) {
            counts[i].count += counts[i - 1].count;
            counts[i - 1].count = 0;
        }
    }

    int min_len = -1;
    char *result = NULL;

    for (int i = 0; i < n; i++) {
        if (counts[i].count == 1) {
            int len = strlen(counts[i].str);
            if (min_len == -1 || len < min_len) {
                min_len = len;
                result = counts[i].str;
            }
        }
    }

    free(counts);
    return result;
}