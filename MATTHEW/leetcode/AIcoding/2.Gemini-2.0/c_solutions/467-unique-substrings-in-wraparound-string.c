#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findSubstringInWraproundString(char * p) {
    int len = strlen(p);
    if (len == 0) return 0;

    int dp[26] = {0};
    int max_len = 0;

    for (int i = 0; i < len; i++) {
        if (i > 0 && (p[i] - p[i - 1] == 1 || (p[i - 1] - p[i] == 25))) {
            max_len++;
        } else {
            max_len = 1;
        }

        int index = p[i] - 'a';
        dp[index] = (dp[index] > max_len) ? dp[index] : max_len;
    }

    int sum = 0;
    for (int i = 0; i < 26; i++) {
        sum += dp[i];
    }

    return sum;
}