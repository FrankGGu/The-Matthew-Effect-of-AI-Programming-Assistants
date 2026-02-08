#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minAnagramLength(char *s, char *p) {
    int sLen = strlen(s);
    int pLen = strlen(p);
    int pFreq[26] = {0};
    for (int i = 0; i < pLen; i++) {
        pFreq[p[i] - 'a']++;
    }

    int minLength = sLen + 1;
    for (int i = 0; i <= sLen - pLen; i++) {
        int sFreq[26] = {0};
        for (int j = i; j < i + pLen; j++) {
            sFreq[s[j] - 'a']++;
        }

        int anagram = 1;
        for (int k = 0; k < 26; k++) {
            if (sFreq[k] != pFreq[k]) {
                anagram = 0;
                break;
            }
        }

        if (anagram) {
            minLength = pLen;
            break;
        }
    }

    if (minLength == sLen + 1) {
        return -1;
    }

    return minLength;
}