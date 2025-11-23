#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int scoreOfString(char* s) {
    int score = 0;
    for (int i = 0; i < strlen(s) - 1; i++) {
        score += abs(s[i] - s[i + 1]);
    }
    return score;
}