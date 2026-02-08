#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

bool isPalindrome(char *s, int start, int end) {
    while (start < end) {
        if (s[start] != s[end]) {
            return false;
        }
        start++;
        end--;
    }
    return true;
}

void dfs(char *s, int start, int *count, int *minCuts) {
    if (start >= strlen(s)) {
        *count = 0;
        return;
    }
    if (minCuts[start] != -1) {
        *count = minCuts[start];
        return;
    }
    int res = INT_MAX;
    for (int end = start; end < strlen(s); end++) {
        if (isPalindrome(s, start, end)) {
            int nextCount;
            dfs(s, end + 1, &nextCount, minCuts);
            res = fmin(res, nextCount + 1);
        }
    }
    minCuts[start] = res;
    *count = res;
}

int minCut(char *s) {
    int n = strlen(s);
    int *minCuts = (int *)malloc(n * sizeof(int));
    memset(minCuts, -1, n * sizeof(int));
    int count;
    dfs(s, 0, &count, minCuts);
    free(minCuts);
    return count - 1;
}