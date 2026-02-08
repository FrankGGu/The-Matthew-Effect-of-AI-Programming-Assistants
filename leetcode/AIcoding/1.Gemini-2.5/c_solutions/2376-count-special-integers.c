#include <string.h>
#include <stdio.h>
#include <stdbool.h>

char s[12]; // Max 10 digits for 10^9, plus null terminator
int len;
int memo[11][1 << 10][2][2]; // idx, mask, tight, is_started

int dp(int idx, int mask, bool tight, bool is_started) {
    if (idx == len) {
        // If is_started is true, a non-zero number was formed.
        // If is_started is false, only leading zeros were placed, effectively forming the number 0.
        // We only count positive integers.
        return is_started ? 1 : 0;
    }

    if (memo[idx][mask][tight][is_started] != -1) {
        return memo[idx][mask][tight][is_started];
    }

    int ans = 0;
    int upper_bound = tight ? (s[idx] - '0') : 9;

    for (int digit = 0; digit <= upper_bound; digit++) {
        if (!is_started && digit == 0) {
            // If we are still placing leading zeros and the current digit is 0,
            // we continue without adding 0 to the mask and keep is_started as false.
            ans += dp(idx + 1, mask, tight && (digit == upper_bound), false);
        } else {
            // If we are placing the first non-zero digit or subsequent digits.
            // Check if the digit has already been used.
            if (mask & (1 << digit)) {
                continue; // Digit is not unique
            }
            // Add the digit to the mask and set is_started to true.
            ans += dp(idx + 1, mask | (1 << digit), tight && (digit == upper_bound), true);
        }
    }

    return memo[idx][mask][tight][is_started] = ans;
}

int countSpecialIntegers(int n) {
    sprintf(s, "%d", n);
    len = strlen(s);
    memset(memo, -1, sizeof(memo));
    return dp(0, 0, true, false);
}