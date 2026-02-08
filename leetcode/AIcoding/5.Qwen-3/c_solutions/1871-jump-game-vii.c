#include <stdio.h>
#include <stdlib.h>

bool canReach(char* s, int idx, int[] dp, int[] visited, int jump) {
    if (idx >= strlen(s)) return false;
    if (s[idx] == '1') return false;
    if (idx == strlen(s) - 1) return true;
    if (visited[idx]) return false;
    visited[idx] = 1;
    if (dp[idx] != -1) return dp[idx];
    bool res = false;
    for (int i = idx + jump; i < strlen(s); i += jump) {
        if (canReach(s, i, dp, visited, jump)) {
            res = true;
            break;
        }
    }
    dp[idx] = res;
    return res;
}

bool canReach(char* s, int idx, int jump) {
    int n = strlen(s);
    int* dp = (int*)malloc(n * sizeof(int));
    int* visited = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dp[i] = -1;
        visited[i] = 0;
    }
    bool result = canReach(s, idx, dp, visited, jump);
    free(dp);
    free(visited);
    return result;
}