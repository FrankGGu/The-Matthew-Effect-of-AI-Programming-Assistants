#include <string.h>
#include <stdlib.h>

int findMirrorScore(char * s) {
    int n = strlen(s);
    int score = 0;
    for (int i = 0; i < n / 2; i++) {
        score += abs(s[i] - s[n - 1 - i]);
    }
    return score;
}