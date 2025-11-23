#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ALPHABET_SIZE 26

int* findAnagrams(char * s, char * p, int* returnSize) {
    int sLen = strlen(s);
    int pLen = strlen(p);
    int* result = (int*)malloc(sLen * sizeof(int));
    *returnSize = 0;

    if (sLen < pLen) return result;

    int pCount[ALPHABET_SIZE] = {0};
    int sCount[ALPHABET_SIZE] = {0};

    for (int i = 0; i < pLen; i++) {
        pCount[p[i] - 'a']++;
        sCount[s[i] - 'a']++;
    }

    if (memcmp(pCount, sCount, sizeof(pCount)) == 0) {
        result[(*returnSize)++] = 0;
    }

    for (int i = pLen; i < sLen; i++) {
        sCount[s[i] - 'a']++;
        sCount[s[i - pLen] - 'a']--;
        if (memcmp(pCount, sCount, sizeof(pCount)) == 0) {
            result[(*returnSize)++] = i - pLen + 1;
        }
    }

    return result;
}