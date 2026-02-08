#include <stdio.h>
#include <stdlib.h>

int calculateScore(char* operations) {
    int score = 0;
    int n = 0;
    for (int i = 0; operations[i] != '\0'; i++) {
        if (operations[i] == 'I') {
            score += 1;
            n++;
        } else if (operations[i] == 'D') {
            score += 2 * n;
        }
    }
    return score;
}