#include <string.h>
#include <stdlib.h>

#define MOD 1000000007

int dp[101][10][2][2];

int solve(char *num, int pos, int prev, int tight, int leading) {
    if (pos == strlen(num)) {
        return !leading ? 1 : 0;
    }

    if (dp[pos][prev][tight][leading] != -1) {
        return dp[pos][prev][tight][leading];
    }

    int limit = tight ? (num[pos] - '0') : 9;
    long long count = 0;

    if (leading) {
        count = (count + solve(num, pos + 1, prev, 0, 1)) % MOD;
        for (int dig = 1; dig <= limit; dig++) {
            count = (count + solve(num, pos + 1, dig, tight && (dig == limit), 0)) % MOD;
        }
    } else {
        for (int dig = 0; dig <= limit; dig++) {
            if (abs(dig - prev) == 1) {
                count = (count + solve(num, pos + 1, dig, tight && (dig == limit), 0)) % MOD;
            }
        }
    }

    return dp[pos][prev][tight][leading] = count;
}

int countSteppingNumbers(char *low, char *high) {
    memset(dp, -1, sizeof(dp));
    int high_count = solve(high, 0, 0, 1, 1);

    memset(dp, -1, sizeof(dp));
    int low_count = solve(low, 0, 0, 1, 1);

    int valid = 1;
    for (int i = 1; i < strlen(low); i++) {
        if (abs(low[i] - low[i - 1]) != 1) {
            valid = 0;
            break;
        }
    }

    int result = (high_count - low_count + valid + MOD) % MOD;
    return result;
}