#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int bagOfTokensScore(int* tokens, int tokensSize, int power){
    int score = 0;
    int left = 0;
    int right = tokensSize - 1;

    qsort(tokens, tokensSize, sizeof(int), cmpfunc);

    while (left <= right) {
        if (power >= tokens[left]) {
            power -= tokens[left];
            score++;
            left++;
        } else if (score > 0 && left < right) {
            power += tokens[right];
            score--;
            right--;
        } else {
            break;
        }
    }

    return score;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}