#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDeletions(char* s) {
    int n = strlen(s);
    int* dp = (int*)malloc(n * sizeof(int));
    int* count = (int*)calloc(26, sizeof(int));

    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    for (int i = 0; i < n; i++) {
        dp[i] = 1;
        for (int j = 0; j < i; j++) {
            if (s[j] != s[i] && count[s[j] - 'a'] > count[s[i] - 'a']) {
                dp[i] = fmax(dp[i], dp[j] + 1);
            }
        }
    }

    int result = 0;
    for (int i = 0; i < n; i++) {
        result = fmax(result, dp[i]);
    }

    free(dp);
    free(count);
    return result;
}