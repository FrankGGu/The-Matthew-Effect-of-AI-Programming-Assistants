#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumScores(char* s) {
    int n = strlen(s);
    int* lps = (int*)malloc(n * sizeof(int));
    memset(lps, 0, n * sizeof(int));

    int len = 0;
    for (int i = 1; i < n; ) {
        if (s[i] == s[len]) {
            len++;
            lps[i] = len;
            i++;
        } else {
            if (len != 0) {
                len = lps[len - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }

    int total = 0;
    for (int i = 0; i < n; i++) {
        total += lps[i];
    }

    free(lps);
    return total;
}