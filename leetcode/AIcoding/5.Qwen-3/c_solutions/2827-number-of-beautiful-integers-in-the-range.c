#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dp[2][2][2][101];
int memo[2][2][2][101];

int dfs(int pos, int tight, int leading_zero, int cnt, char *s) {
    if (pos == strlen(s)) {
        return cnt == 0 ? 1 : 0;
    }
    if (memo[tight][leading_zero][cnt] != -1) {
        return memo[tight][leading_zero][cnt];
    }
    int limit = tight ? s[pos] - '0' : 9;
    int res = 0;
    for (int d = 0; d <= limit; ++d) {
        int new_tight = tight && (d == limit);
        int new_leading_zero = leading_zero && (d == 0);
        int new_cnt = cnt;
        if (!new_leading_zero) {
            if (d % 2 == 0) {
                new_cnt++;
            } else {
                new_cnt--;
            }
        }
        if (new_cnt < 0) continue;
        res += dfs(pos + 1, new_tight, new_leading_zero, new_cnt, s);
    }
    memo[tight][leading_zero][cnt] = res;
    return res;
}

int f(char *s) {
    memset(memo, -1, sizeof(memo));
    return dfs(0, 1, 1, 0, s);
}

int numberOfBeautifulIntegers(char * low, char * high) {
    int len_low = strlen(low);
    int len_high = strlen(high);
    int res = 0;
    char *temp = (char *)malloc(len_high + 1);
    strcpy(temp, high);
    res += f(temp);
    for (int i = 0; i < len_low; ++i) {
        temp[i] = low[i];
    }
    for (int i = len_low; i < len_high; ++i) {
        temp[i] = '0';
    }
    res -= f(temp);
    free(temp);
    return res;
}