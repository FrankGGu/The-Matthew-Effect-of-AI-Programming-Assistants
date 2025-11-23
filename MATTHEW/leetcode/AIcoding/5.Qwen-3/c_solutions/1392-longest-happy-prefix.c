#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestPrefixSuffix(char *s) {
    int n = strlen(s);
    int *lps = (int *)malloc(n * sizeof(int));
    lps[0] = 0;
    int len = 0;
    for (int i = 1; i < n;) {
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
    int result = lps[n - 1];
    free(lps);
    return result;
}

int longestHappyPrefix(char *s) {
    return longestPrefixSuffix(s);
}