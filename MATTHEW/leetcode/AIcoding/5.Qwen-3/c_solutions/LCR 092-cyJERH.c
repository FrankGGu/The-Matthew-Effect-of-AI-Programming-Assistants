#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minFlipsMonoIncr(char *s) {
    int n = strlen(s);
    int flip = 0;
    int count = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '1') {
            count++;
        } else {
            flip++;
        }
    }

    int minFlip = flip;
    for (int i = 0; i < n; i++) {
        if (s[i] == '1') {
            count--;
            flip = (flip - 1) > 0 ? (flip - 1) : 0;
        } else {
            flip++;
        }
        minFlip = (minFlip < flip) ? minFlip : flip;
    }

    return minFlip;
}