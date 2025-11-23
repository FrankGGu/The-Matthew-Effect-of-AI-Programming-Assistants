#include <stdio.h>
#include <string.h>

char* smallestString(char* s, int n) {
    for (int i = 0; i < n; i++) {
        if (s[i] == 'a') {
            break;
        }
        s[i] = s[i] > 'a' ? 'a' : s[i];
    }
    return s;
}