#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int shiftDistance(char *s, char *t, int m, int n) {
    int i = 0, j = 0;
    while (i < m && j < n) {
        if (s[i] == t[j]) {
            i++;
            j++;
        } else {
            int k = j;
            while (k < n && s[i] != t[k]) {
                k++;
            }
            if (k == n) {
                return -1;
            }
            j = k + 1;
        }
    }
    return (i == m && j <= n) ? 0 : -1;
}