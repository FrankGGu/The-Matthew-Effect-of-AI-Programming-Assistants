#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORD_LEN 100
#define MAX_WORDS 1000

int countWords(char **words, int wordsSize) {
    int count = 0;
    int freq[256] = {0};

    for (int i = 0; i < wordsSize; i++) {
        freq[words[i][0]]++;
    }

    for (int i = 0; i < wordsSize; i++) {
        if (freq[words[i][0]] == 1) {
            count++;
        }
    }

    return count;
}

int countCommonWords(char **words1, int words1Size, char **words2, int words2Size) {
    int freq1[256] = {0}, freq2[256] = {0};

    for (int i = 0; i < words1Size; i++) {
        freq1[words1[i][0]]++;
    }
    for (int i = 0; i < words2Size; i++) {
        freq2[words2[i][0]]++;
    }

    int commonCount = 0;
    for (char ch = 'a'; ch <= 'z'; ch++) {
        if (freq1[ch] == 1 && freq2[ch] == 1) {
            commonCount++;
        }
    }

    return commonCount;
}