#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char *s) {
    int n = strlen(s);
    int count = 0;

    for (int i = 0; i < n; i++) {
        int l = i, r = i;
        while (l >= 0 && r < n && s[l] == s[r]) {
            count++;
            l--;
            r++;
        }
    }

    for (int i = 0; i < n; i++) {
        int l = i, r = i + 1;
        while (l >= 0 && r < n && s[l] == s[r]) {
            count++;
            l--;
            r++;
        }
    }

    return count;
}