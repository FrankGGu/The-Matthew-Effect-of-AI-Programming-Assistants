#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* smallestSubsequence(char* s, int k, char c) {
    int n = strlen(s);
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == c) count++;
    }
    int need = k - (count - 1);
    int len = n - k;
    char* res = (char*)malloc((k + 1) * sizeof(char));
    int top = 0;
    for (int i = 0; i < n; i++) {
        while (top > 0 && res[top - 1] > s[i] && len > 0) {
            len--;
            top--;
        }
        res[top++] = s[i];
    }
    res[k] = '\0';
    return res;
}