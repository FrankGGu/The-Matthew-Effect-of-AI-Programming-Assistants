#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct CharCount {
    char ch;
    int count;
};

int cmp(const void *a, const void *b) {
    return ((struct CharCount *)b)->count - ((struct CharCount *)a)->count;
}

char *frequencySort(char *s) {
    int freq[256] = {0};
    for (int i = 0; s[i]; i++) {
        freq[(unsigned char)s[i]]++;
    }

    struct CharCount counts[256];
    int index = 0;
    for (int i = 0; i < 256; i++) {
        if (freq[i] > 0) {
            counts[index].ch = (char)i;
            counts[index].count = freq[i];
            index++;
        }
    }

    qsort(counts, index, sizeof(struct CharCount), cmp);

    char *result = (char *)malloc(strlen(s) + 1);
    int pos = 0;
    for (int i = 0; i < index; i++) {
        for (int j = 0; j < counts[i].count; j++) {
            result[pos++] = counts[i].ch;
        }
    }
    result[pos] = '\0';
    return result;
}