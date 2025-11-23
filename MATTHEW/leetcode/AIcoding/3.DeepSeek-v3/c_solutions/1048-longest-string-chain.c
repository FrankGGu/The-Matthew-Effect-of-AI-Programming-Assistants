int compare(const void *a, const void *b) {
    return strlen(*(char**)a) - strlen(*(char**)b);
}

bool isPredecessor(char *a, char *b) {
    int lenA = strlen(a);
    int lenB = strlen(b);
    if (lenA + 1 != lenB) return false;

    int i = 0, j = 0;
    while (i < lenA && j < lenB) {
        if (a[i] == b[j]) {
            i++;
        }
        j++;
    }
    return i == lenA;
}

int longestStrChain(char ** words, int wordsSize){
    qsort(words, wordsSize, sizeof(char*), compare);

    int *dp = (int*)malloc(wordsSize * sizeof(int));
    for (int i = 0; i < wordsSize; i++) {
        dp[i] = 1;
    }

    int maxChain = 1;
    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (isPredecessor(words[j], words[i])) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                }
            }
        }
        if (dp[i] > maxChain) {
            maxChain = dp[i];
        }
    }

    free(dp);
    return maxChain;
}