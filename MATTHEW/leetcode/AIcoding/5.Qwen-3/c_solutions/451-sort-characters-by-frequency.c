#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char ch;
    int count;
} CharFreq;

int compare(const void *a, const void *b) {
    CharFreq *x = (CharFreq *)a;
    CharFreq *y = (CharFreq *)b;
    return y->count - x->count;
}

char* sortCharactersByFrequency(char* s) {
    int len = strlen(s);
    if (len == 0) return "";

    int freq[256] = {0};
    for (int i = 0; i < len; i++) {
        freq[(unsigned char)s[i]]++;
    }

    CharFreq *charFreq = (CharFreq *)malloc(256 * sizeof(CharFreq));
    int count = 0;
    for (int i = 0; i < 256; i++) {
        if (freq[i] > 0) {
            charFreq[count].ch = (char)i;
            charFreq[count].count = freq[i];
            count++;
        }
    }

    qsort(charFreq, count, sizeof(CharFreq), compare);

    char *result = (char *)malloc((len + 1) * sizeof(char));
    int index = 0;
    for (int i = 0; i < count; i++) {
        for (int j = 0; j < charFreq[i].count; j++) {
            result[index++] = charFreq[i].ch;
        }
    }
    result[index] = '\0';

    free(charFreq);
    return result;
}