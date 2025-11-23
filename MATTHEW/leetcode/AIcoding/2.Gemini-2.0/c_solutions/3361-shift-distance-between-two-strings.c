#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int shiftDistance(char *s, char *t) {
    int n = strlen(s);
    int m = strlen(t);

    if (n != m) {
        return -1;
    }

    for (int shift = 0; shift < n; shift++) {
        bool match = true;
        for (int i = 0; i < n; i++) {
            if (s[i] != t[(i + shift) % n]) {
                match = false;
                break;
            }
        }
        if (match) {
            return shift;
        }
    }

    return -1;
}