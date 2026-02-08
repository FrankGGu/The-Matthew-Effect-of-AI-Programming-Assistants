#include <stdio.h>
#include <stdlib.h>

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int bagOfTokensScore(int* tokens, int tokensSize, int power, int score) {
    qsort(tokens, tokensSize, sizeof(int), cmpfunc);
    int left = 0;
    int right = tokensSize - 1;
    while (left <= right) {
        if (power >= tokens[left]) {
            power -= tokens[left];
            score++;
            left++;
        } else if (score > 0) {
            power += tokens[right];
            score--;
            right--;
        } else {
            break;
        }
    }
    return score;
}