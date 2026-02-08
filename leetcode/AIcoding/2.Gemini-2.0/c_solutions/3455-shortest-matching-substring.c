#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int shortestMatchingSubstr(char *s, char *t) {
    int n = strlen(s);
    int m = strlen(t);
    if (m > n) return -1;

    int min_len = INT_MAX;

    for (int i = 0; i <= n - m; i++) {
        int j;
        for (j = 0; j < m; j++) {
            if (s[i + j] != t[j]) {
                break;
            }
        }
        if (j == m) {
            min_len = m;
            break;
        }
    }

    if(min_len == m) return min_len;

    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int sub_len = j - i + 1;
            char sub[sub_len + 1];
            strncpy(sub, s + i, sub_len);
            sub[sub_len] = '\0';

            int k;
            for(k = 0; k < m; k++){
                if(strstr(sub, t) != NULL){
                    break;
                }
            }
            if (strstr(sub, t) != NULL) {
                if (sub_len < min_len) {
                    min_len = sub_len;
                }
            }
        }
    }

    if (min_len == INT_MAX) {
        return -1;
    }

    return min_len;
}