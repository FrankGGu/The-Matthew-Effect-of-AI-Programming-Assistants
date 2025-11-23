#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findAnagrams(char * s, char * p, int* returnSize){
    int sLen = strlen(s);
    int pLen = strlen(p);
    if (pLen > sLen) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(sizeof(int) * sLen);
    *returnSize = 0;

    int pFreq[26] = {0};
    int sFreq[26] = {0};

    for (int i = 0; i < pLen; i++) {
        pFreq[p[i] - 'a']++;
        sFreq[s[i] - 'a']++;
    }

    for (int i = 0; i <= sLen - pLen; i++) {
        int match = 1;
        for (int j = 0; j < 26; j++) {
            if (pFreq[j] != sFreq[j]) {
                match = 0;
                break;
            }
        }

        if (match) {
            result[(*returnSize)++] = i;
        }

        if (i < sLen - pLen) {
            sFreq[s[i] - 'a']--;
            sFreq[s[i + pLen] - 'a']++;
        }
    }

    return result;
}