#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minSeconds(int* s, int sSize) {
    int* count = (int*)calloc(256, sizeof(int));
    for (int i = 0; i < sSize; i++) {
        count[s[i]]++;
    }

    int maxFreq = 0;
    for (int i = 0; i < 256; i++) {
        if (count[i] > maxFreq) {
            maxFreq = count[i];
        }
    }

    int result = 0;
    for (int i = 0; i < sSize; i++) {
        if (count[s[i]] == maxFreq) {
            result = (sSize - 1) / maxFreq;
            break;
        }
    }

    free(count);
    return result;
}