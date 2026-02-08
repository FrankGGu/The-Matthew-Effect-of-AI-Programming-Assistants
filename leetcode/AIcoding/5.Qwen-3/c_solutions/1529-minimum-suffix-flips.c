#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSuffixFlips(char *s) {
    int flips = 0;
    char prev = '0';
    for (int i = 0; s[i]; i++) {
        if (s[i] != prev) {
            flips++;
            prev = s[i];
        }
    }
    return flips;
}