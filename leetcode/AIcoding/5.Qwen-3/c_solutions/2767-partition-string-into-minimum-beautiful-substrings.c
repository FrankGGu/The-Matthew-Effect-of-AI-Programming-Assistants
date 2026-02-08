#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int isBeautiful(char* s, int start, int end) {
    int count[26] = {0};
    for (int i = start; i <= end; i++) {
        count[s[i] - 'a']++;
    }
    for (int i = 0; i < 26; i++) {
        if (count[i] > 1) return 0;
    }
    return 1;
}

int dp(char* s, int index, int* memo) {
    if (index == strlen(s)) return 0;
    if (memo[index] != -1) return memo[index];

    int minSubstrings = INT_MAX;
    for (int end = index; end < strlen(s); end++) {
        if (isBeautiful(s, index, end)) {
            int res = dp(s, end + 1, memo);
            if (res != INT_MAX) {
                minSubstrings = min(minSubstrings, 1 + res);
            }
        }
    }
    memo[index] = minSubstrings;
    return minSubstrings;
}

int partitionString(char* s) {
    int n = strlen(s);
    int* memo = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        memo[i] = -1;
    }
    int result = dp(s, 0, memo);
    free(memo);
    return result;
}