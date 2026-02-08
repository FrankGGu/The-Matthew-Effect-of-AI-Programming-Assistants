#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int strStr(char *haystack, char *needle) {
    if (needle == NULL || needle[0] == '\0') {
        return 0;
    }
    if (haystack == NULL) {
        return -1;
    }

    int n = strlen(haystack);
    int m = strlen(needle);

    if (m > n) {
        return -1;
    }

    for (int i = 0; i <= n - m; i++) {
        int j;
        for (j = 0; j < m; j++) {
            if (haystack[i + j] != needle[j]) {
                break;
            }
        }
        if (j == m) {
            return i;
        }
    }

    return -1;
}

int prefix_function(char *s, int *pi) {
    int n = strlen(s);
    pi[0] = 0;
    for (int i = 1; i < n; i++) {
        int j = pi[i - 1];
        while (j > 0 && s[i] != s[j]) {
            j = pi[j - 1];
        }
        if (s[i] == s[j]) {
            j++;
        }
        pi[i] = j;
    }
    return 0;
}

int findGoodStrings(int n, char *s1, char *s2, char *evil) {
    int m = strlen(evil);
    int pi[m];
    prefix_function(evil, pi);

    long long dp[n + 1][m + 1][2][2];
    memset(dp, 0, sizeof(dp));
    dp[0][0][1][1] = 1;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j <= m; j++) {
            for (int f1 = 0; f1 < 2; f1++) {
                for (int f2 = 0; f2 < 2; f2++) {
                    for (char c = 'a'; c <= 'z'; c++) {
                        if (f1 && c < s1[i]) continue;
                        if (f2 && c > s2[i]) continue;

                        int nj = j;
                        while (nj > 0 && c != evil[nj]) {
                            nj = pi[nj - 1];
                        }
                        if (c == evil[nj]) {
                            nj++;
                        }

                        if (nj == m) continue;

                        int nf1 = f1 && (c == s1[i]);
                        int nf2 = f2 && (c == s2[i]);

                        dp[i + 1][nj][nf1][nf2] = (dp[i + 1][nj][nf1][nf2] + dp[i][j][f1][f2]) % MOD;
                    }
                }
            }
        }
    }

    long long ans = 0;
    for (int j = 0; j <= m; j++) {
        for (int f1 = 0; f1 < 2; f1++) {
            for (int f2 = 0; f2 < 2; f2++) {
                ans = (ans + dp[n][j][f1][f2]) % MOD;
            }
        }
    }

    return (int)ans;
}