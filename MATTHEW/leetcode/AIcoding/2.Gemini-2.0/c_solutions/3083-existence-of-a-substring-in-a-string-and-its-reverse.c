#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool exist(char * s, char * t) {
    int n = strlen(s);
    int m = strlen(t);
    if (m > n) return false;
    for (int i = 0; i <= n - m; i++) {
        if (strncmp(s + i, t, m) == 0) return true;
    }
    return false;
}

char* reverse(char* str) {
    int len = strlen(str);
    char* reversed = (char*)malloc(len + 1);
    for (int i = 0; i < len; i++) {
        reversed[i] = str[len - 1 - i];
    }
    reversed[len] = '\0';
    return reversed;
}

bool solve(char * a, char * b){
    if (exist(a, b)) return true;
    char* reversed_b = reverse(b);
    bool result = exist(a, reversed_b);
    free(reversed_b);
    return result;
}