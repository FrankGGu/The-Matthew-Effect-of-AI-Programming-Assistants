#include <string.h>

int numDistinct(char * s, char * t){
    int m = strlen(s);
    int n = strlen(t);

    if (n == 0) {
        return 1;
    }
    if (m == 0) {
        return 0;
    }

    long long dp[m + 1][n + 1];

    for (int i = 0; i <= m; i++) {
        dp[i][0] = 1;
    }

    for (int j = 1; j <= n; j++) {
        dp[0][j] = 0;
    }

    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            if (s[i-1] == t[j-1]) {
                dp[i][j] = dp[i-1][j-1] + dp[i-1][j];
            } else {
                dp[i][j] = dp[i-1][j];
            }
        }
    }

    return (int)dp[m][n];
}