#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * longestPrefix(char * s){
    int n = strlen(s);
    int *lps = (int *)malloc(sizeof(int) * n);
    lps[0] = 0;
    int len = 0;
    int i = 1;

    while (i < n) {
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

    int prefix_len = lps[n - 1];
    char *result = (char *)malloc(sizeof(char) * (prefix_len + 1));
    strncpy(result, s, prefix_len);
    result[prefix_len] = '\0';
    free(lps);
    return result;
}