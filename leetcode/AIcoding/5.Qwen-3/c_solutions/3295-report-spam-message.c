#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool areAlmostEqual(char* s, char* t) {
    int n = strlen(s);
    if (n != strlen(t)) return false;

    int diffCount = 0;
    int pos1 = -1, pos2 = -1;

    for (int i = 0; i < n; i++) {
        if (s[i] != t[i]) {
            diffCount++;
            if (diffCount == 1) {
                pos1 = i;
            } else if (diffCount == 2) {
                pos2 = i;
            } else {
                return false;
            }
        }
    }

    return (diffCount == 0) || (diffCount == 2 && s[pos1] == t[pos2] && s[pos2] == t[pos1]);
}