#include <string.h>
#include <stdlib.h>

#define MOD 1000000007

int dp[23][401][2][2];

int solve(char *num, int pos, int sum, int tight, int leading, int min_sum, int max_sum) {
    if (pos == strlen(num)) {
        return (sum >= min_sum && sum <= max_sum) ? 1 : 0;
    }

    if (dp[pos][sum][tight][leading] != -1) {
        return dp[pos][sum][tight][leading];
    }

    int limit = tight ? (num[pos] - '0') : 9;
    long long res = 0;

    for (int dig = 0; dig <= limit; dig++) {
        int new_tight = tight && (dig == limit);
        int new_leading = leading && (dig == 0);
        int new_sum = sum + dig;

        if (new_leading) {
            res = (res + solve(num, pos + 1, 0, new_tight, new_leading, min_sum, max_sum)) % MOD;
        } else {
            res = (res + solve(num, pos + 1, new_sum, new_tight, new_leading, min_sum, max_sum)) % MOD;
        }
    }

    return dp[pos][sum][tight][leading] = res;
}

int count(char *num, int min_sum, int max_sum) {
    memset(dp, -1, sizeof(dp));
    return solve(num, 0, 0, 1, 1, min_sum, max_sum);
}

int countStrings(char *num1, char *num2, int min_sum, int max_sum) {
    int res1 = count(num1, min_sum, max_sum);
    int res2 = count(num2, min_sum, max_sum);

    int sum_num1 = 0;
    for (int i = 0; num1[i]; i++) {
        sum_num1 += num1[i] - '0';
    }
    int valid_num1 = (sum_num1 >= min_sum && sum_num1 <= max_sum) ? 1 : 0;

    return (res2 - res1 + valid_num1 + MOD) % MOD;
}

int count(char *num, int min_sum, int max_sum) {
    memset(dp, -1, sizeof(dp));
    return solve(num, 0, 0, 1, 1, min_sum, max_sum);
}

int countStrings(char *num1, char *num2, int min_sum, int max_sum) {
    int res1 = count(num1, min_sum, max_sum);
    int res2 = count(num2, min_sum, max_sum);

    int sum_num1 = 0;
    for (int i = 0; num1[i]; i++) {
        sum_num1 += num1[i] - '0';
    }
    int valid_num1 = (sum_num1 >= min_sum && sum_num1 <= max_sum) ? 1 : 0;

    return (res2 - res1 + valid_num1 + MOD) % MOD;
}