#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int bagOfTokens(int* tokens, int tokensSize, int power) {
    qsort(tokens, tokensSize, sizeof(int), compare);
    int left = 0;
    int right = tokensSize - 1;
    int maxScore = 0;
    int currentScore = 0;

    while (left <= right) {
        if (power >= tokens[left]) {
            power -= tokens[left];
            left++;
            currentScore++;
            if (currentScore > maxScore) {
                maxScore = currentScore;
            }
        } else if (currentScore > 0) {
            power += tokens[right];
            right--;
            currentScore--;
        } else {
            break;
        }
    }

    return maxScore;
}