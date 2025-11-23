#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * shortestPalindrome(char * s){
    int n = strlen(s);
    if (n == 0) return "";

    char *t = (char *)malloc((2 * n + 2) * sizeof(char));
    int k = 0;
    for (int i = 0; i < n; i++) {
        t[k++] = s[i];
    }
    t[k++] = '#';
    for (int i = n - 1; i >= 0; i--) {
        t[k++] = s[i];
    }
    t[k] = '\0';

    int *lps = (int *)malloc((2 * n + 1) * sizeof(int));
    lps[0] = 0;
    int len = 0;
    int i = 1;
    while (i < 2 * n + 1) {
        if (t[i] == t[len]) {
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

    int prefixLen = lps[2 * n];

    char *prefix = (char *)malloc((n - prefixLen + 1) * sizeof(char));
    k = 0;
    for (int i = n - 1; i >= prefixLen; i--) {
        prefix[k++] = s[i];
    }
    prefix[k] = '\0';

    char *result = (char *)malloc((strlen(prefix) + n + 1) * sizeof(char));
    strcpy(result, prefix);
    strcat(result, s);

    free(t);
    free(lps);
    free(prefix);

    return result;
}