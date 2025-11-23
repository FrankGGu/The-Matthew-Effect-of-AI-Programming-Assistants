#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(char *)a - *(char *)b);
}

bool checkIfCanBreak(char * s1, char * s2){
    int n = strlen(s1);
    qsort(s1, n, sizeof(char), cmp);
    qsort(s2, n, sizeof(char), cmp);

    bool s1_greater = true;
    bool s2_greater = true;

    for (int i = 0; i < n; i++) {
        if (s1[i] < s2[i]) {
            s1_greater = false;
        }
        if (s2[i] < s1[i]) {
            s2_greater = false;
        }
    }

    return s1_greater || s2_greater;
}