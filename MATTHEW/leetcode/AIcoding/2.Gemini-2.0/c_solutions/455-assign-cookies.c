#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int findContentChildren(int* g, int gSize, int* s, int sSize){
    qsort(g, gSize, sizeof(int), cmpfunc);
    qsort(s, sSize, sizeof(int), cmpfunc);

    int content = 0;
    int cookieIndex = 0;
    int childIndex = 0;

    while (cookieIndex < sSize && childIndex < gSize) {
        if (s[cookieIndex] >= g[childIndex]) {
            content++;
            childIndex++;
        }
        cookieIndex++;
    }

    return content;
}