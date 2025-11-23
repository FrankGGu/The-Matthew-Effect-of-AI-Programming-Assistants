#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *file;
    int size;
} File;

int compare(const void *a, const void to) {
    File *x = (File *)a;
    File *y = (File *)to;
    return x->size - y->size;
}

int findContentChildren(int* g, int gSize, int* s, int sSize) {
    qsort(g, gSize, sizeof(int), (int (*)(const void*, const void*))compare);
    qsort(s, sSize, sizeof(int), (int (*)(const void*, const void*))compare);

    int i = 0, j = 0;
    while (i < gSize && j < sSize) {
        if (s[j] >= g[i]) {
            i++;
        }
        j++;
    }
    return i;
}