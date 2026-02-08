#include <string.h>
#include <stdlib.h>
#include <stdio.h>

static int integer_pow(int base, int exp) {
    int res = 1;
    for (int i = 0; i < exp; i++) {
        res *= base;
    }
    return res;
}

int atMostNFromDigitSet(char** digits, int digitsSize, int n) {
    char N_str[11];
    sprintf(N_str, "%d", n);
    int L = strlen(N_str);
    int S = digitsSize;
    int ans = 0;

    for (int i = 1; i < L; i++) {
        ans += integer_pow(S, i);
    }

    int prefix_match = 1;

    for (int i = 0; i < L; i++) {
        int N_digit = N_str[i] - '0';
        int current_digit_match_found = 0;

        for (int j = 0; j < S; j++) {
            int D_digit = digits[j][0] - '0';

            if (D_digit < N_digit) {
                ans += integer_pow(S, L - 1 - i);
            } else if (D_digit == N_digit) {
                current_digit_match_found = 1;
                break;
            } else {
                prefix_match = 0;
                break;
            }
        }

        if (prefix_match == 0) {
            break;
        }

        if (current_digit_match_found == 0) {
            prefix_match = 0;
            break;
        }
    }

    if (prefix_match) {
        ans += 1;
    }

    return ans;
}