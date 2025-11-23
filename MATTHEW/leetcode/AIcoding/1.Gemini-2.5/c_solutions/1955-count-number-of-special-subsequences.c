#include <string.h>

int countSpecialSubsequences(char * s){
    long long dp0 = 0;
    long long dp1 = 0;
    long long dp2 = 0;
    long long MOD = 1000000007;

    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        if (s[i] == '0') {
            dp0 = (2 * dp0 + 1) % MOD;
        } else if (s[i] == '1') {
            dp1 = (2 * dp1 + dp0) % MOD;
        } else if (s[i] == '2') {
            dp2 = (2 * dp2 + dp1) % MOD;
        }
    }

    return (int)dp2;
}