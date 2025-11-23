#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int strStr(char * haystack, char * needle) {
    if (needle[0] == '\0') {
        return 0;
    }

    int len_haystack = strlen(haystack);
    int len_needle = strlen(needle);

    for (int i = 0; i <= len_haystack - len_needle; i++) {
        int j;
        for (j = 0; j < len_needle; j++) {
            if (haystack[i + j] != needle[j]) {
                break;
            }
        }
        if (j == len_needle) {
            return i;
        }
    }

    return -1;
}