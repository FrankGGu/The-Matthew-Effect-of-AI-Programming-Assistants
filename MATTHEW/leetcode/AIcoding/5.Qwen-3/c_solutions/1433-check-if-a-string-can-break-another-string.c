#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(char*)a - *(char*)b);
}

bool checkIfCanBreak(char *s1, char *s2) {
    int len = strlen(s1);
    qsort(s1, len, sizeof(char), compare);
    qsort(s2, len, sizeof(char), compare);

    bool canBreak = true;
    for (int i = 0; i < len; i++) {
        if (s1[i] < s2[i]) {
            canBreak = false;
            break;
        }
    }

    if (canBreak) return true;

    canBreak = true;
    for (int i = 0; i < len; i++) {
        if (s2[i] < s1[i]) {
            canBreak = false;
            break;
        }
    }

    return canBreak;
}