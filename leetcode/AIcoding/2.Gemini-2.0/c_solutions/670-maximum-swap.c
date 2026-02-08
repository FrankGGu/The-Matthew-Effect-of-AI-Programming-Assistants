#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumSwap(int num) {
    char s[11];
    sprintf(s, "%d", num);
    int len = 0;
    while (s[len] != '\0') {
        len++;
    }

    int maxIndex[len];
    maxIndex[len - 1] = len - 1;
    for (int i = len - 2; i >= 0; i--) {
        if (s[i] > s[maxIndex[i + 1]]) {
            maxIndex[i] = i;
        } else {
            maxIndex[i] = maxIndex[i + 1];
        }
    }

    for (int i = 0; i < len; i++) {
        if (s[i] != s[maxIndex[i]]) {
            char temp = s[i];
            s[i] = s[maxIndex[i]];
            s[maxIndex[i]] = temp;
            return atoi(s);
        }
    }

    return num;
}