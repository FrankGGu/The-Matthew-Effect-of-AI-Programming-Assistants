#include <string.h>
#include <stdlib.h>

char S[105];
long long memo[105][2][11][2];

long long solve(int idx, int tight, int prev_digit, int is_leading_zero) {
    if (idx == strlen(S)) {
        return 1;
    }
    if (memo[idx][tight][prev_digit + 1][is_leading_zero] != -1) {
        return memo[idx][tight][prev_digit + 1][is_leading_zero];
    }

    long long ans = 0;
    int upper_bound = tight ? (S[idx] - '0') : 9;

    for (int digit = 0; digit <= upper_bound; digit++) {
        if (is_leading_zero) {
            if (digit == 0) {
                ans += solve(idx + 1, tight && (digit == upper_bound), -1, 1);
            } else {
                ans += solve(idx + 1, tight && (digit == upper_bound), digit, 0);
            }
        } else {
            if (abs(digit - prev_digit) == 1) {
                ans += solve(idx + 1, tight && (digit == upper_bound), digit, 0);
            }
        }
    }
    return memo[idx][tight][prev_digit + 1][is_leading_zero] = ans;
}

char* subtractOne(char* num_str) {
    int n = strlen(num_str);
    char* res = (char*)malloc(sizeof(char) * (n + 2));
    strcpy(res, num_str);
    int i = n - 1;
    while (i >= 0 && res[i] == '0') {
        res[i] = '9';
        i--;
    }
    if (i < 0) {
        strcpy(res, "");
        return res;
    }
    res[i]--;
    if (res[0] == '0' && n > 1) {
        memmove(res, res + 1, n);
        res[n - 1] = '\0';
    }
    return res;
}

long long countSteppingNumbers(char* low, char* high) {
    memset(memo, -1, sizeof(memo));
    strcpy(S, high);
    long long ans_high = solve(0, 1, -1, 1);

    char* low_minus_1_str = subtractOne(low);
    long long ans_low_minus_1 = 0;
    if (strlen(low_minus_1_str) > 0) {
        memset(memo, -1, sizeof(memo));
        strcpy(S, low_minus_1_str);
        ans_low_minus_1 = solve(0, 1, -1, 1);
    }
    free(low_minus_1_str);

    return ans_high - ans_low_minus_1;
}