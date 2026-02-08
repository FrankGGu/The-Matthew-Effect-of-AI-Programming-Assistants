#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSwapsToMakeBalanced(char* s) {
    int open = 0;
    int close = 0;
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] == '[') {
            open++;
        } else {
            close++;
        }
        if (close > open) {
            open++;
            close--;
        }
    }
    return (open - close + 1) / 2;
}