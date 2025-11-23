#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int overlap(char *s1, char *s2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    int max_overlap = 0;
    for (int i = 1; i <= fmin(len1, len2); i++) {
        if (strncmp(s1 + len1 - i, s2, i) == 0) {
            max_overlap = i;
        }
    }
    return max_overlap;
}

char* shortestSuperstring(char** A, int ASize) {
    int n = ASize;
    int adj[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i != j) {
                adj[i][j] = overlap(A[i], A[j]);
            } else {
                adj[i][j] = 0;
            }
        }
    }

    int dp[1 << n][n];
    int parent[1 << n][n];
    memset(dp, 0, sizeof(dp));
    memset(parent, -1, sizeof(parent));

    for (int mask = 1; mask < (1 << n); mask++) {
        for (int j = 0; j < n; j++) {
            if (mask & (1 << j)) {
                int prev_mask = mask ^ (1 << j);
                if (prev_mask == 0) {
                    dp[mask][j] = strlen(A[j]);
                } else {
                    for (int i = 0; i < n; i++) {
                        if (i != j && (prev_mask & (1 << i))) {
                            int val = dp[prev_mask][i] + strlen(A[j]) - adj[i][j];
                            if (val > dp[mask][j]) {
                                dp[mask][j] = val;
                                parent[mask][j] = i;
                            }
                        }
                    }
                }
            }
        }
    }

    int mask = (1 << n) - 1;
    int last = 0;
    for (int j = 1; j < n; j++) {
        if (dp[mask][j] > dp[mask][last]) {
            last = j;
        }
    }

    char* result = (char*)malloc(sizeof(char) * 1000);
    result[0] = '\0';
    int index = 0;
    int path[n];
    for (int i = 0; i < n; i++) path[i] = -1;

    for (int i = n - 1; i >= 0; i--) {
        path[i] = last;
        int temp = parent[mask][last];
        mask ^= (1 << last);
        last = temp;
        if (mask == 0) break;
    }

    int k = 0;
    while (path[k] == -1) k++;
    strcpy(result, A[path[k]]);
    int res_len = strlen(result);

    for (int i = k + 1; i < n; i++) {
        int o = overlap(result, A[path[i]]);
        strcat(result, A[path[i]] + o);
    }

    return result;
}