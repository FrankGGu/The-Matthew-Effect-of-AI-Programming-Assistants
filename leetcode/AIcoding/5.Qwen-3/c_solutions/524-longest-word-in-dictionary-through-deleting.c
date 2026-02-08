#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    const char *strA = *(const char**)a;
    const char *strB = *(const char**)b;
    int lenA = strlen(strA);
    int lenB = strlen(strB);
    if (lenA != lenB) return lenB - lenA;
    return strcmp(strA, strB);
}

int isSubsequence(char *s, char *d) {
    int i = 0, j = 0;
    while (s[i] && d[j]) {
        if (s[i] == d[j]) j++;
        i++;
    }
    return d[j] == '\0';
}

char* findLongestWord(char* s, char** d, int dSize) {
    qsort(d, dSize, sizeof(char*), compare);
    char* result = NULL;
    for (int i = 0; i < dSize; i++) {
        if (isSubsequence(s, d[i])) {
            result = d[i];
            break;
        }
    }
    return result;
}