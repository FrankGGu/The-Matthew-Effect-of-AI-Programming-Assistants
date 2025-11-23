#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int monotoneIncreasingDigits(int n) {
    char s[12];
    sprintf(s, "%d", n);
    int len = strlen(s);

    int nineStartIdx = len;

    for (int i = len - 2; i >= 0; i--) {
        if (s[i] > s[i+1]) {
            s[i]--;
            nineStartIdx = i + 1;
        }
    }

    for (int i = nineStartIdx; i < len; i++) {
        s[i] = '9';
    }

    return atoi(s);
}