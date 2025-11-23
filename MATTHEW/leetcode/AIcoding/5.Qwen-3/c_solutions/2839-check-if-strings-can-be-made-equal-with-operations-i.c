#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool areAlmostEqual(char* s, char* t) {
    int len = strlen(s);
    if (len != strlen(t)) return false;

    int diffCount = 0;
    for (int i = 0; i < len; i++) {
        if (s[i] != t[i]) {
            diffCount++;
            if (diffCount > 2) return false;
        }
    }
    return diffCount == 2;
}