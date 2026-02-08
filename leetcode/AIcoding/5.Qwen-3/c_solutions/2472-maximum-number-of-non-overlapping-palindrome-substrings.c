#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxNumOfSubstrings(char *s) {
    int n = strlen(s);
    int dp[n];
    int count = 0;
    int last = -1;

    for (int i = 0; i < n; i++) {
        dp[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        int l = i, r = i;
        while (l >= 0 && r < n && s[l] == s[r]) {
            if (l == r) {
                dp[r] = 1;
            } else {
                dp[r] = dp[l] + 1;
            }
            l--;
            r++;
        }

        l = i;
        r = i + 1;
        while (l >= 0 && r < n && s[l] == s[r]) {
            if (l == r) {
                dp[r] = 1;
            } else {
                dp[r] = dp[l] + 1;
            }
            l--;
            r++;
        }
    }

    for (int i = 0; i < n; i++) {
        if (dp[i] > 0 && i > last) {
            count++;
            last = i;
        }
    }

    return count;
}