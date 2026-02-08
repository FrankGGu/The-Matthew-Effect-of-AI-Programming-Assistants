#include <stdlib.h>
#include <string.h>

typedef struct {
    char c;
    int freq;
} CharFreq;

int compareCharFreq(const void* a, const void* b) {
    CharFreq* cf1 = (CharFreq*)a;
    CharFreq* cf2 = (CharFreq*)b;
    return cf2->freq - cf1->freq;
}

char* frequencySort(char* s) {
    int freqMap[256] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        freqMap[(unsigned char)s[i]]++;
    }

    CharFreq charFreqs[256];
    int uniqueCharCount = 0;
    for (int i = 0; i < 256; i++) {
        if (freqMap[i] > 0) {
            charFreqs[uniqueCharCount].c = (char)i;
            charFreqs[uniqueCharCount].freq = freqMap[i];
            uniqueCharCount++;
        }
    }

    qsort(charFreqs, uniqueCharCount, sizeof(CharFreq), compareCharFreq);

    char* result = (char*)malloc(sizeof(char) * (len + 1));
    if (result == NULL) {
        return NULL;
    }

    int currentPos = 0;
    for (int i = 0; i < uniqueCharCount; i++) {
        for (int j = 0; j < charFreqs[i].freq; j++) {
            result[currentPos++] = charFreqs[i].c;
        }
    }
    result[currentPos] = '\0';

    return result;
}