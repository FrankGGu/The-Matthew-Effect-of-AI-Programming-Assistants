#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumTimeToInitialState(char* s, int k) {
    int n = strlen(s);
    int* lps = (int*)malloc(n * sizeof(int));
    lps[0] = 0;
    int len = 0;

    for (int i = 1; i < n; i++) {
        while (len > 0 && s[i] != s[len]) {
            len = lps[len - 1];
        }
        if (s[i] == s[len]) {
            len++;
            lps[i] = len;
        } else {
            lps[i] = 0;
        }
    }

    int result = 0;
    int i = 0;
    while (i < n) {
        result += k;
        i += k;
        if (i >= n) break;
        int j = i;
        while (j < n && s[j] == s[j - i]) {
            j++;
        }
        if (j == n) {
            free(lps);
            return result;
        }
    }

    free(lps);
    return result;
}