#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool solve(const char *s, long long prev) {
    if (*s == '\0') {
        return true;
    }

    long long curr = 0;
    int i = 0;
    while (s[i] != '\0') {
        curr = curr * 10 + (s[i] - '0');
        if (prev == -1 || curr == prev - 1) {
            if (solve(s + i + 1, curr)) {
                return true;
            }
        }
        if (curr >= prev && prev != -1) break;
        i++;
    }
    return false;
}

bool splitString(char * s){
    return solve(s, -1);
}