#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumValue(char** s, int sSize) {
    int max = 0;
    for (int i = 0; i < sSize; i++) {
        int len = strlen(s[i]);
        if (len > max) {
            max = len;
        }
    }
    return max;
}