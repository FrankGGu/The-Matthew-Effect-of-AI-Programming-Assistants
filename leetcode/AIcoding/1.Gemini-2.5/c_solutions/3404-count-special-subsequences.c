#include <string.h>

int countSpecialSubsequences(char * s){
    int dp1 = 0;
    int dp2 = 0;
    int dp3 = 0;
    const int MOD = 1000000007;

    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        char c = s[i];
        if (c == '1') {
            dp1 = (2 * dp1 % MOD + 1) % MOD;
        } else if (c == '2') {
            dp2 = (2 * dp2 % MOD + dp1) % MOD;
        } else if (c == '3') {
            dp3 = (2 * dp3 % MOD + dp2) % MOD;
        }
    }

    return dp3;
}