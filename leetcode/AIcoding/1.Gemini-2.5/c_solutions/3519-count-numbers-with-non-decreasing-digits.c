#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

long long C[20][20];
bool combinations_precomputed = false;

void precompute_combinations_once() {
    if (!combinations_precomputed) {
        for (int i = 0; i < 20; ++i) {
            C[i][0] = 1;
            for (int j = 1; j <= i; ++j) {
                C[i][j] = C[i-1][j-1] + C[i-1][j];
            }
        }
        combinations_precomputed = true;
    }
}

long long get_combinations(int n_val, int k_val) {
    if (k_val < 0 || k_val > n_val) {
        return 0;
    }
    return C[n_val][k_val];
}

bool is_non_decreasing(char* s) {
    for (int i = 0; s[i+1] != '\0'; ++i) {
        if (s[i] > s[i+1]) {
            return false;
        }
    }
    return true;
}

int countNumbers(int n) {
    if (n == 0) {
        return 0;
    }

    precompute_combinations_once();

    char s[12]; 
    sprintf(s, "%d", n);
    int len = strlen(s);
    long long ans = 0;

    for (int k = 1; k < len; ++k) {
        ans += get_combinations(9 + k - 1, k);
    }

    int last_digit = 1;
    for (int i = 0; i < len; ++i) {
        int curr_d = s[i] - '0';

        for (int j = last_digit; j < curr_d; ++j) {
            int k_rem = len - 1 - i;
            int m_options = 9 - j + 1;
            ans += get_combinations(m_options + k_rem - 1, k_rem);
        }

        if (curr_d < last_digit) {
            break;
        }
        last_digit = curr_d;
    }

    if (is_non_decreasing(s)) {
        ans++;
    }

    return (int)ans;
}