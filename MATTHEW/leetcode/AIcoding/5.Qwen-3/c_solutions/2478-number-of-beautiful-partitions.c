#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfBeautifulPartitions(char* s, int k) {
    int n = strlen(s);
    if (n < k) return 0;
    if (k == 1) return 1;

    int isVowel[256] = {0};
    isVowel['A'] = isVowel['E'] = isVowel['I'] = isVowel['O'] = isVowel['U'] =
        isVowel['a'] = isVowel['e'] = isVowel['i'] = isVowel['o'] = isVowel['u'] = 1;

    int dp[k][n];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < n; i++) {
        if (isVowel[s[i]] && (i == 0 || !isVowel[s[i - 1]])) {
            dp[0][i] = 1;
        }
    }

    for (int t = 1; t < k; t++) {
        for (int i = 0; i < n; i++) {
            if (!isVowel[s[i]] || (i > 0 && isVowel[s[i - 1]])) continue;
            for (int j = 0; j < i; j++) {
                if (isVowel[s[j]] && (j == 0 || !isVowel[s[j - 1]])) {
                    dp[t][i] += dp[t - 1][j];
                }
            }
        }
    }

    int result = 0;
    for (int i = 0; i < n; i++) {
        if (isVowel[s[i]] && (i == 0 || !isVowel[s[i - 1]])) {
            result += dp[k - 1][i];
        }
    }

    return result;
}