#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char *s, char *t) {
    int m = strlen(s);
    int n = strlen(t);
    int count = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int diff = 0;
            int k = 0;
            while (i + k < m && j + k < n) {
                if (s[i + k] != t[j + k]) {
                    diff++;
                }
                if (diff == 1) {
                    count++;
                } else if (diff > 1) {
                    break;
                }
                k++;
            }
        }
    }

    return count;
}