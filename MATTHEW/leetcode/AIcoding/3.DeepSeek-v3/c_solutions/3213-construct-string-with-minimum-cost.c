typedef struct {
    char* key;
    int cost;
    UT_hash_handle hh;
} HashItem;

int min(int a, int b) {
    return a < b ? a : b;
}

int minimumCost(char* target, char** words, int wordsSize, int* costs, int costsSize) {
    HashItem* memo = NULL;
    int n = strlen(target);
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        if (dp[i] == INT_MAX) continue;
        for (int j = 0; j < wordsSize; j++) {
            int len = strlen(words[j]);
            if (i + len > n) continue;

            int k = 0;
            while (k < len && target[i + k] == words[j][k]) {
                k++;
            }
            if (k == len) {
                dp[i + len] = min(dp[i + len], dp[i] + costs[j]);
            }
        }
    }

    int res = dp[n] == INT_MAX ? -1 : dp[n];
    free(dp);

    HashItem *curr, *tmp;
    HASH_ITER(hh, memo, curr, tmp) {
        HASH_DEL(memo, curr);
        free(curr->key);
        free(curr);
    }

    return res;
}