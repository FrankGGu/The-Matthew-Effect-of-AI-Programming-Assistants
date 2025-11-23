#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int stringToInt(char* str, int start, int end) {
    int num = 0;
    for (int i = start; i <= end; i++) {
        num = num * 10 + (str[i] - '0');
    }
    return num;
}

int restoreTheArray(char* s, int k) {
    int n = 0;
    while (s[n] != '\0') {
        n++;
    }

    int mod = 1000000007;
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dp[i] = 0;
    }
    dp[n] = 1;

    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == '0') {
            continue;
        }
        for (int j = i; j < n; j++) {
            int num = stringToInt(s, i, j);
            if (num >= 1 && num <= k) {
                dp[i] = (dp[i] + dp[j + 1]) % mod;
            } else {
                break;
            }
        }
    }

    int result = dp[0];
    free(dp);
    return result;
}