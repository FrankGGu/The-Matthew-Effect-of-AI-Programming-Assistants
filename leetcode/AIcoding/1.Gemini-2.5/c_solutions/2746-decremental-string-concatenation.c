#include <string.h>
#include <limits.h>

static int min(int a, int b) {
    return a < b ? a : b;
}

int minimizeConcatenatedLength(char **words, int wordsSize) {
    int n = wordsSize;

    int lengths[n];
    int first_chars[n];
    int last_chars[n];

    for (int i = 0; i < n; ++i) {
        lengths[i] = strlen(words[i]);
        first_chars[i] = words[i][0] - 'a';
        last_chars[i] = words[i][lengths[i] - 1] - 'a';
    }

    int dp[1 << n][26];

    for (int i = 0; i < (1 << n); ++i) {
        for (int j = 0; j < 26; ++j) {
            dp[i][j] = INT_MAX;
        }
    }

    for (int i = 0; i < n; ++i) {
        int mask = (1 << i);
        dp[mask][last_chars[i]] = lengths[i];
    }

    for (int mask = 1; mask < (1 << n); ++mask) {
        for (int last_char_prev_word_idx = 0; last_char_prev_word_idx < 26; ++last_char_prev_word_idx) {
            if (dp[mask][last_char_prev_word_idx] == INT_MAX) {
                continue;
            }

            for (int j = 0; j < n; ++j) {
                if (!(mask & (1 << j))) {
                    int new_mask = mask | (1 << j);

                    int cost_to_append = lengths[j];
                    if (last_char_prev_word_idx == first_chars[j]) {
                        cost_to_append--;
                    }

                    int new_total_cost = dp[mask][last_char_prev_word_idx] + cost_to_append;

                    dp[new_mask][last_chars[j]] = min(dp[new_mask][last_chars[j]], new_total_cost);
                }
            }
        }
    }

    int min_total_cost = INT_MAX;
    int final_mask = (1 << n) - 1;
    for (int i = 0; i < 26; ++i) {
        min_total_cost = min(min_total_cost, dp[final_mask][i]);
    }

    return min_total_cost;
}