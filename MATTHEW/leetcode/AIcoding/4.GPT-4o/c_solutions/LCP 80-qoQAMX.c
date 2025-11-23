#include <stdio.h>
#include <string.h>

char * strStr(char * haystack, char * needle) {
    if (*needle == '\0') return haystack;
    int haystackLen = strlen(haystack);
    int needleLen = strlen(needle);
    for (int i = 0; i <= haystackLen - needleLen; i++) {
        if (strncmp(haystack + i, needle, needleLen) == 0) {
            return haystack + i;
        }
    }
    return NULL;
}