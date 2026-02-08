#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char* s, int n) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (s[i] == s[j]) {
                count++;
            }
        }
    }
    return count;
}

int countSubarrays(char* s, int n) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (s[i] == s[j]) {
                count++;
            }
        }
    }
    return count;
}

int countCells(char* s) {
    int n = strlen(s);
    int h = countSubstrings(s, n);
    int v = countSubarrays(s, n);
    return h + v;
}