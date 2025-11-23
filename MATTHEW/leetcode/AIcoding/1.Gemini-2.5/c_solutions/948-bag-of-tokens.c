#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int bagOfTokensScore(int* tokens, int tokensSize, int power) {
    if (tokensSize == 0) {
        return 0;
    }

    qsort(tokens, tokensSize, sizeof(int), compare);

    int score = 0;
    int max_score = 0;
    int left = 0;
    int right = tokensSize - 1;

    while (left <= right) {
        if (power >= tokens[left]) {
            power -= tokens[left];
            score++;
            left++;
            if (score > max_score) {
                max_score = score;
            }
        } else if (score >= 1 && left < right) {
            power += tokens[right];
            score--;
            right--;
        } else {
            break;
        }
    }

    return max_score;
}