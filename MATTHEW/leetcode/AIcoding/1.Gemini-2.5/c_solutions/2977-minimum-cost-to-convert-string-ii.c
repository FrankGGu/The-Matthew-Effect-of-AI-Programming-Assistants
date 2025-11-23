#include <string.h> // For strlen, strncmp
#include <stdlib.h> // For malloc, free
#include <limits.h> // For LLONG_MAX

long long min(long long a, long long b) {
    return a < b ? a : b;
}

long long minimumCost(char * source, char * target, char ** original, char ** changed, int* cost, int m){
    int n = strlen(source);

    long long min_char_cost[26][26];
    for (int i = 0; i < 26; ++i) {
        for (int j = 0; j < 26; ++j) {
            if (i == j) {
                min_char_cost[i][j] = 0;
            } else {
                min_char_cost[i][j] = LLONG_MAX;
            }
        }
    }

    for (int k = 0; k < m; ++k) {
        if (strlen(original[k]) == 1 && strlen(changed[k]) == 1) {
            int u = original[k][0] - 'a';
            int v = changed[k][0] - 'a';
            min_char_cost[u][v] = min(min_char_cost[u][v], (long long)cost[k]);
        }
    }

    for (int k_fw = 0; k_fw < 26; ++k_fw) {
        for (int i_fw = 0; i_fw < 26; ++i_fw) {
            for (int j_fw = 0; j_fw < 26; ++j_fw) {
                if (min_char_cost[i_fw][k_fw] != LLONG_MAX && min_char_cost[k_fw][j_fw] != LLONG_MAX) {
                    min_char_cost[i_fw][j_fw] = min(min_char_cost[i_fw][j_fw], min_char_cost[i_fw][k_fw] + min_char_cost[k_fw][j_fw]);
                }
            }
        }
    }

    long long *dp = (long long *)malloc((n + 1) * sizeof(long long));
    if (!dp) {
        return -1; 
    }

    for (int i = 0; i <= n; ++i) {
        dp[i] = LLONG_MAX;
    }
    dp[0] = 0;

    for (int i = 0; i < n; ++i) {
        if (dp[i] == LLONG_MAX) {
            continue;
        }

        int u = source[i] - 'a';
        int v = target[i] - 'a';
        if (min_char_cost[u][v] != LLONG_MAX) {
            dp[i+1] = min(dp[i+1], dp[i] + min_char_cost[u][v]);
        }

        for (int rule_idx = 0; rule_idx < m; ++rule_idx) {
            int rule_len = strlen(original[rule_idx]);

            if (i + rule_len <= n) {
                if (strncmp(&source[i], original[rule_idx], rule_len) == 0) {
                    if (strncmp(&target[i], changed[rule_idx], rule_len) == 0) {
                        dp[i + rule_len] = min(dp[i + rule_len], dp[i] + (long long)cost[rule_idx]);
                    }
                }
            }
        }
    }

    long long result = dp[n];
    free(dp);

    return (result == LLONG_MAX) ? -1 : result;
}