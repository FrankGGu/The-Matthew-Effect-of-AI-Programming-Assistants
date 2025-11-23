#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char key;
    int count;
} CharCount;

int compare(const void *a, const void *b) {
    return ((CharCount *)a)->count - ((CharCount *)b)->count;
}

bool areOccurrencesEqual(char *s) {
    int len = strlen(s);
    CharCount counts[26];
    int uniqueChars = 0;

    for (int i = 0; i < 26; i++) {
        counts[i].key = 'a' + i;
        counts[i].count = 0;
    }

    for (int i = 0; i < len; i++) {
        for (int j = 0; j < 26; j++) {
            if (counts[j].key == s[i]) {
                counts[j].count++;
                break;
            }
        }
    }

    for (int i = 0; i < 26; i++) {
        if (counts[i].count > 0) {
            uniqueChars++;
        }
    }

    qsort(counts, 26, sizeof(CharCount), compare);

    int firstCount = counts[0].count;
    for (int i = 1; i < uniqueChars; i++) {
        if (counts[i].count != firstCount) {
            return false;
        }
    }

    return true;
}