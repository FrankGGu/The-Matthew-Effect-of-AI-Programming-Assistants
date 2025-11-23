#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findMirrorScore(char* s) {
    int n = strlen(s);
    int score = 0;
    for (int i = 0; i < n / 2; i++) {
        if (s[i] != s[n - 1 - i]) {
            score++;
        }
    }
    return score;
}