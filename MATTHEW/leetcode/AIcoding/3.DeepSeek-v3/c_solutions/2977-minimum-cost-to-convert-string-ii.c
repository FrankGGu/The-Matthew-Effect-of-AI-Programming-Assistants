typedef struct {
    char original[11];
    char changed[11];
    int cost;
} Conversion;

typedef struct {
    char key[11];
    long long cost;
    UT_hash_handle hh;
} HashItem;

long long minCost(char* source, char* target, char** original, int originalSize, char** changed, int changedSize, int* cost, int costSize) {
    Conversion conversions[originalSize];
    for (int i = 0; i < originalSize; i++) {
        strcpy(conversions[i].original, original[i]);
        strcpy(conversions[i].changed, changed[i]);
        conversions[i].cost = cost[i];
    }

    HashItem *graph = NULL;
    for (int i = 0; i < originalSize; i++) {
        char key[22];
        sprintf(key, "%s-%s", conversions[i].original, conversions[i].changed);

        HashItem *entry = NULL;
        HASH_FIND_STR(graph, key, entry);
        if (entry) {
            if (conversions[i].cost < entry->cost) {
                entry->cost = conversions[i].cost;
            }
        } else {
            entry = malloc(sizeof(HashItem));
            strcpy(entry->key, key);
            entry->cost = conversions[i].cost;
            HASH_ADD_STR(graph, key, entry);
        }
    }

    int n = strlen(source);
    long long dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = LLONG_MAX;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        if (dp[i] == LLONG_MAX) continue;
        if (source[i] == target[i]) {
            if (dp[i + 1] > dp[i]) {
                dp[i + 1] = dp[i];
            }
        }
        for (int len = 1; len <= 10 && i + len <= n; len++) {
            char sub1[11], sub2[11];
            strncpy(sub1, source + i, len);
            strncpy(sub2, target + i, len);
            sub1[len] = '\0';
            sub2[len] = '\0';

            if (strcmp(sub1, sub2) == 0) {
                if (dp[i + len] > dp[i]) {
                    dp[i + len] = dp[i];
                }
                continue;
            }

            char key[22];
            sprintf(key, "%s-%s", sub1, sub2);
            HashItem *entry = NULL;
            HASH_FIND_STR(graph, key, entry);
            if (entry) {
                if (dp[i + len] > dp[i] + entry->cost) {
                    dp[i + len] = dp[i] + entry->cost;
                }
            }
        }
    }

    HashItem *curr, *tmp;
    HASH_ITER(hh, graph, curr, tmp) {
        HASH_DEL(graph, curr);
        free(curr);
    }

    return dp[n] == LLONG_MAX ? -1 : dp[n];
}