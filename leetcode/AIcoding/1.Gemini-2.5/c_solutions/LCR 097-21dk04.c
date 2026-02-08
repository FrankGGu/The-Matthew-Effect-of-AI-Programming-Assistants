#include <string.h>
#include <stdlib.h>

long long numDistinct(char * s, char * t){
    int len_s = strlen(s);
    int len_t = strlen(t);

    if (len_t == 0) {
        return 1;
    }
    if (len_s == 0) {
        return 0;
    }

    long long *dp = (long long *)calloc(len_t + 1, sizeof(long long));
    if (dp == NULL) {
        return 0; 
    }

    dp[0] = 1;

    for (int i = 0; i < len_s; i++) {
        for (int j = len_t; j > 0; j--) {
            if (s[i] == t[j-1]) {
                dp[j] += dp[j-1];
            }
        }
    }

    long long result = dp[len_t];
    free(dp);
    return result;
}