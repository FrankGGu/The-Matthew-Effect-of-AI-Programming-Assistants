#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* shortestPalindrome(char* s) {
    int n = strlen(s);
    char* rev = (char*)malloc((n + 1) * sizeof(char));
    strcpy(rev, s);
    for (int i = 0; i < n / 2; i++) {
        char temp = rev[i];
        rev[i] = rev[n - 1 - i];
        rev[n - 1 - i] = temp;
    }
    int l = 0;
    int r = n;
    while (r > 0) {
        if (strncmp(s, rev + n - r, r) == 0) {
            break;
        }
        r--;
    }
    char* result = (char*)malloc((n + (n - r) + 1) * sizeof(char));
    strncpy(result, rev, n - r);
    strcat(result, s);
    free(rev);
    return result;
}