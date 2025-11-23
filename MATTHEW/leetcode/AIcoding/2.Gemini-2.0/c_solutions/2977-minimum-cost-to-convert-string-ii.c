#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 2005
#define MAXL 27

long long minimumCost(char * source, char * target, char ** original, int originalSize, char ** changed, int changedSize, int* cost, int costSize){
    int n = strlen(source);
    int m = strlen(target);

    long long adj[MAXL][MAXL];
    for (int i = 0; i < MAXL; i++) {
        for (int j = 0; j < MAXL; j++) {
            adj[i][j] = (i == j) ? 0 : LLONG_MAX / 2;
        }
    }

    for (int i = 0; i < changedSize; i++) {
        adj[original[i][0] - 'a'][changed[i][0] - 'a'] = cost[i];
    }

    for (int k = 0; k < MAXL; k++) {
        for (int i = 0; i < MAXL; i++) {
            for (int j = 0; j < MAXL; j++) {
                adj[i][j] = (adj[i][j] < adj[i][k] + adj[k][j]) ? adj[i][j] : (adj[i][k] + adj[k][j]);
            }
        }
    }

    long long dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = LLONG_MAX / 2;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        if (dp[i] == LLONG_MAX / 2) continue;

        for (int j = 0; j < originalSize; j++) {
            int len = strlen(original[j]);
            if (i + len <= n && strncmp(source + i, original[j], len) == 0) {
                if (strncmp(target + i, changed[j], len) == 0) {
                    dp[i + len] = (dp[i + len] < dp[i] + cost[j]) ? dp[i + len] : (dp[i] + cost[j]);
                }
            }
        }
        if(source[i] == target[i]){
            dp[i+1] = (dp[i+1] < dp[i])? dp[i+1] : dp[i];
            continue;
        }
        long long c = adj[source[i] - 'a'][target[i] - 'a'];
        if (c != LLONG_MAX / 2){
            dp[i+1] = (dp[i+1] < dp[i] + c) ? dp[i+1] : (dp[i] + c);
        }

    }

    return (dp[n] >= LLONG_MAX / 2) ? -1 : dp[n];
}