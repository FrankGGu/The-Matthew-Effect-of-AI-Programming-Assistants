#include <string.h>

int countSubstrings(char * s, char * t){
    int n = strlen(s);
    int m = strlen(t);
    int ans = 0;

    int dp_prefix[n + 1][m + 1];
    int dp_suffix[n + 1][m + 1];

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= m; j++) {
            dp_prefix[i][j] = 0;
            dp_suffix[i][j] = 0;
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        for (int j = m - 1; j >= 0; j--) {
            if (s[i] == t[j]) {
                dp_prefix[i][j] = 1 + dp_prefix[i + 1][j + 1];
            } else {
                dp_prefix[i][j] = 0;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (s[i] == t[j]) {
                dp_suffix[i + 1][j + 1] = 1 + dp_suffix[i][j];
            } else {
                dp_suffix[i + 1][j + 1] = 0;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (s[i] != t[j]) {
                int left_common = dp_suffix[i][j];
                int right_common = dp_prefix[i + 1][j + 1];
                ans += (left_common + 1) * (right_common + 1);
            }
        }
    }

    return ans;
}