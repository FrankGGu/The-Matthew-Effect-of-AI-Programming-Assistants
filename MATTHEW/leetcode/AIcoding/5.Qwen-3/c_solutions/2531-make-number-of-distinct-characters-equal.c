#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char ch;
    int count;
} CharCount;

int compare(const void *a, const void *b) {
    return ((CharCount *)b)->count - ((CharCount *)a)->count;
}

int getDistinctCount(char *s) {
    int distinct = 0;
    int seen[256] = {0};
    for (int i = 0; s[i]; i++) {
        if (!seen[(unsigned char)s[i]]) {
            seen[(unsigned char)s[i]] = 1;
            distinct++;
        }
    }
    return distinct;
}

bool canMakeEqual(char *s, char *t) {
    int lenS = strlen(s);
    int lenT = strlen(t);
    if (lenS != lenT) return false;

    int distinctS = getDistinctCount(s);
    int distinctT = getDistinctCount(t);

    if (distinctS != distinctT) return false;

    int freqS[256] = {0};
    int freqT[256] = {0};

    for (int i = 0; s[i]; i++) {
        freqS[(unsigned char)s[i]]++;
        freqT[(unsigned char)t[i]]++;
    }

    CharCount countsS[256];
    CharCount countsT[256];
    int countS = 0, countT = 0;

    for (int i = 0; i < 256; i++) {
        if (freqS[i] > 0) {
            countsS[countS].ch = i;
            countsS[countS++].count = freqS[i];
        }
        if (freqT[i] > 0) {
            countsT[countT].ch = i;
            countsT[countT++].count = freqT[i];
        }
    }

    qsort(countsS, countS, sizeof(CharCount), compare);
    qsort(countsT, countT, sizeof(CharCount), compare);

    for (int i = 0; i < countS; i++) {
        if (countsS[i].count != countsT[i].count) return false;
    }

    return true;
}