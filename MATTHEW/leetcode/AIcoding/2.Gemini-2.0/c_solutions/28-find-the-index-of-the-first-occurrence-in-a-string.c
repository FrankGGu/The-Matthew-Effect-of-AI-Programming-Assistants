#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int strStr(char * haystack, char * needle){
    int haystack_len = 0;
    int needle_len = 0;
    int i, j;

    while (haystack[haystack_len] != '\0') {
        haystack_len++;
    }

    while (needle[needle_len] != '\0') {
        needle_len++;
    }

    if (needle_len == 0) {
        return 0;
    }

    if (haystack_len < needle_len) {
        return -1;
    }

    for (i = 0; i <= haystack_len - needle_len; i++) {
        for (j = 0; j < needle_len; j++) {
            if (haystack[i + j] != needle[j]) {
                break;
            }
        }
        if (j == needle_len) {
            return i;
        }
    }

    return -1;
}