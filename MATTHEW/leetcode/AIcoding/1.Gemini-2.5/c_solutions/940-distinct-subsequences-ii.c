#include <string.h>

int distinctSubseqII(char * s) {
    long long MOD = 1000000007;
    int n = strlen(s);

    long long ends_with[26] = {0};
    long long total_distinct_subsequences = 0;

    for (int i = 0; i < n; i++) {
        int char_idx = s[i] - 'a';

        long long new_count_for_char = (total_distinct_subsequences + 1) % MOD;

        total_distinct_subsequences = (total_distinct_subsequences + new_count_for_char - ends_with[char_idx] + MOD) % MOD;

        ends_with[char_idx] = new_count_for_char;
    }

    return (int)total_distinct_subsequences;
}