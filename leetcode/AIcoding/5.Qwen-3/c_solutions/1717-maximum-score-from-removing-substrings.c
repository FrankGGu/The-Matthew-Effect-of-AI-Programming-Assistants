#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumScore(char* s, char* a, char* b) {
    int score = 0;
    int len = strlen(s);
    int i = 0;

    while (i < len) {
        if (s[i] == a[0] && i + 1 < len && s[i+1] == a[1]) {
            score += 10;
            i += 2;
        } else if (s[i] == b[0] && i + 1 < len && s[i+1] == b[1]) {
            score += 5;
            i += 2;
        } else {
            i++;
        }
    }

    return score;
}