#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char ch;
    int freq;
} CharFreq;

int compare(const void *a, const void *b) {
    return ((CharFreq*)b)->freq - ((CharFreq*)a)->freq;
}

char * frequencySort(char * s){
    int len = strlen(s);
    CharFreq freq[256] = {0};
    for (int i = 0; i < 256; i++) {
        freq[i].ch = (char)i;
        freq[i].freq = 0;
    }

    for (int i = 0; i < len; i++) {
        freq[s[i]].freq++;
    }

    qsort(freq, 256, sizeof(CharFreq), compare);

    char *result = (char*)malloc(sizeof(char) * (len + 1));
    int index = 0;
    for (int i = 0; i < 256; i++) {
        for (int j = 0; j < freq[i].freq; j++) {
            result[index++] = freq[i].ch;
        }
    }
    result[index] = '\0';

    return result;
}