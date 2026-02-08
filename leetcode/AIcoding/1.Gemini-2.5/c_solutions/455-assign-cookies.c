#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findContentChildren(int* g, int gSize, int* s, int sSize) {
    qsort(g, gSize, sizeof(int), compare);
    qsort(s, sSize, sizeof(int), compare);

    int child_idx = 0;
    int cookie_idx = 0;
    int content_children = 0;

    while (child_idx < gSize && cookie_idx < sSize) {
        if (s[cookie_idx] >= g[child_idx]) {
            content_children++;
            child_idx++;
            cookie_idx++;
        } else {
            cookie_idx++;
        }
    }

    return content_children;
}