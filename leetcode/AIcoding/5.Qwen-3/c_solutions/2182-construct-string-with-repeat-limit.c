#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char c;
    int count;
} CharCount;

int compare(const void *a, const void *b) {
    return ((CharCount *)b)->count - ((CharCount *)a)->count;
}

char *repeatedStringWithLimit(char *s, int limit) {
    int len = strlen(s);
    CharCount counts[26];
    memset(counts, 0, sizeof(counts));

    for (int i = 0; i < len; i++) {
        counts[s[i] - 'a'].c = s[i];
        counts[s[i] - 'a'].count++;
    }

    qsort(counts, 26, sizeof(CharCount), compare);

    char *result = (char *)malloc(sizeof(char) * (len + 1));
    int result_len = 0;

    int i = 0;
    while (i < 26 && counts[i].count > 0) {
        if (counts[i].count <= limit) {
            for (int j = 0; j < counts[i].count; j++) {
                result[result_len++] = counts[i].c;
            }
            counts[i].count = 0;
        } else {
            for (int j = 0; j < limit; j++) {
                result[result_len++] = counts[i].c;
            }
            counts[i].count -= limit;
        }

        i++;

        if (i < 26 && counts[i].count > 0) {
            for (int j = 0; j < 1; j++) {
                result[result_len++] = counts[i].c;
            }
            counts[i].count--;

            if (counts[i].count == 0) {
                i++;
            }
        }
    }

    result[result_len] = '\0';
    return result;
}