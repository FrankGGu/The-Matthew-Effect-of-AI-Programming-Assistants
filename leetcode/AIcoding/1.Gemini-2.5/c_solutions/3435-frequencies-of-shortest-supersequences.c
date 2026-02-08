#include <string.h>
#include <stdlib.h>

#define MOD 1000000007

int shortestCommonSupersequence(char * str1, char * str2) {
    int n = strlen(str1);
    int m = strlen(str2);

    int** dp_len = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        dp_len[i] = (int*)malloc((m + 1) * sizeof(int));
    }

    int** dp_count = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        dp_count[i] = (int*)malloc((m + 1) * sizeof(int));
    }

    for (int j = 0; j <= m; j++) {
        dp_len[0][j] = j;
        dp_count[0][j] = 1;
    }

    for (int i = 0; i <= n; i++) {
        dp_len[i][0] = i;
        dp_count[i][0] = 1;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            if (str1[i - 1] == str2[j - 1]) {
                dp_len[i][j] = 1 + dp_len[i - 1][j - 1];
                dp_count[i][j] = dp_count[i - 1][j - 1];
            } else {
                int len_option1 = 1 + dp_len[i - 1][j];
                int len_option2 = 1 + dp_len[i][j - 1];

                if (len_option1 < len_option2) {
                    dp_len[i][j] = len_option1;
                    dp_count[i][j] = dp_count[i - 1][j];
                } else if (len_option2 < len_option1) {
                    dp_len[i][j] = len_option2;
                    dp_count[i][j] = dp_count[i][j - 1];
                } else {
                    dp_len[i][j] = len_option1;
                    dp_count[i][j] = (dp_count[i - 1][j] + dp_count[i][j - 1]) % MOD;
                }
            }
        }
    }

    int result = dp_count[n][m];

    for (int i = 0; i <= n; i++) {
        free(dp_len[i]);
        free(dp_count[i]);
    }
    free(dp_len);
    free(dp_count);

    return result;
}