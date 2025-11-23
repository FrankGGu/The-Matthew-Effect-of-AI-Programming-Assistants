#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* replaceDigits(int n, char* s) {
    for (int i = 1; i < n; i += 2) {
        if (s[i] == '?') {
            s[i] = s[i - 1] + 1;
        }
    }
    return s;
}