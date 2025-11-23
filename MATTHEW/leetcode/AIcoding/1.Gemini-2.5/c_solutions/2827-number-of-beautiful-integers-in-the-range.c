#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

int global_K;
char num_str[15];
long long memo[11][2][11][11][21][2];

void init_memo() {
    for (int i = 0; i < 11; ++i) {
        for (int j = 0; j < 2; ++j) {
            for (int l = 0; l < 11; ++l) {
                for (int m = 0; m < 11; ++m) {
                    for (int n = 0; n < 21; ++n) {
                        for (int o = 0; o < 2; ++o) {
                            memo[i][j][l][m][n][o] = -1;
                        }
                    }
                }
            }
        }
    }
}

long long solve(int index, bool tight, int even_count, int odd_count, int current_sum_mod_k, bool is_leading_zero) {
    if (index == strlen(num_str)) {
        return (even_count > 0 && even_count == odd_count && current_sum_mod_k == 0) ? 1 : 0;
    }

    if (memo[index][tight][even_count][odd_count][current_sum_mod_k][is_leading_zero] != -1) {
        return memo[index][tight][even_count][odd_count][current_sum_mod_k][is_leading_zero];
    }

    long long ans = 0;
    int upper_bound = tight ? (num_str[index] - '0') : 9;

    for (int digit = 0; digit <= upper_bound; ++digit) {
        if (is_leading_zero) {
            if (digit == 0) {
                ans += solve(index + 1, tight && (digit == upper_bound), 0, 0, 0, true);
            } else {
                int new_even_count = (digit % 2 == 0) ? 1 : 0;
                int new_odd_count = (digit % 2 != 0) ? 1 : 0;
                int new_sum_mod_k = digit % global_K;
                ans += solve(index + 1, tight && (digit == upper_bound), new_even_count, new_odd_count, new_sum_mod_k, false);
            }
        } else {
            int new_even_count = even_count + (digit % 2 == 0 ? 1 : 0);
            int new_odd_count = odd_count + (digit % 2 != 0 ? 1 : 0);
            int new_sum_mod_k = (current_sum_mod_k * 10 + digit) % global_K;
            ans += solve(index + 1, tight && (digit == upper_bound), new_even_count, new_odd_count, new_sum_mod_k, false);
        }
    }

    return memo[index][tight][even_count][odd_count][current_sum_mod_k][is_leading_zero] = ans;
}

void ull_to_str(long long n, char* s) {
    sprintf(s, "%lld", n);
}

long long count_beautiful_integers_up_to_N(long long n, int k) {
    if (n == 0) return 0;
    ull_to_str(n, num_str);
    global_K = k;
    init_memo();
    return solve(0, true, 0, 0, 0, true);
}

int numberOfBeautifulIntegers(int low, int high, int k) {
    long long ans_high = count_beautiful_integers_up_to_N(high, k);
    long long ans_low_minus_1 = count_beautiful_integers_up_to_N(low - 1, k);
    return (int)(ans_high - ans_low_minus_1);
}