#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(char*)a - *(char*)b);
}

bool isAnagram(char *s, char *t) {
    if (strlen(s) != strlen(t)) {
        return false;
    }
    qsort(s, strlen(s), sizeof(char), compare);
    qsort(t, strlen(t), sizeof(char), compare);
    return strcmp(s, t) == 0;
}