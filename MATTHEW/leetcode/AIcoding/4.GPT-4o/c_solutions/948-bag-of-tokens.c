int bagOfTokensScore(int* tokens, int tokensSize, int P) {
    qsort(tokens, tokensSize, sizeof(int), cmp);
    int score = 0, maxScore = 0, left = 0, right = tokensSize - 1;

    while (left <= right) {
        if (P >= tokens[left]) {
            P -= tokens[left++];
            score++;
            maxScore = score > maxScore ? score : maxScore;
        } else if (score > 0) {
            P += tokens[right--];
            score--;
        } else {
            break;
        }
    }

    return maxScore;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}