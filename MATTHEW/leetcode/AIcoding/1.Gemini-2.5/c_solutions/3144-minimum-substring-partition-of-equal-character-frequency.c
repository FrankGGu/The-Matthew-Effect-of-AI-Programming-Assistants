#include <string.h>
#include <limits.h>
#include <stdlib.h>

int minimumSubstringsInPartition(char* s) {
    int n = strlen(s);

    int* dp = (int*)malloc((n + 1) * sizeof(int));

    dp[0] = 0;
    for (int i = 1; i <= n; i++) {
        dp[i] = INT_MAX;
    }

    int* freq_counts = (int*)malloc((n + 1) * sizeof(int));

    for (int i = 1; i <= n; i++) {
        int freq[26];
        memset(freq, 0, sizeof(freq));

        memset(freq_counts, 0, (n + 1) * sizeof(int));

        int num_distinct_non_zero_freqs = 0;

        for (int j = i - 1; j >= 0; j--) {
            char c = s[j];
            int char_idx = c - 'a';

            int old_freq_val = freq[char_idx];
            int new_freq_val = old_freq_val + 1;

            if (old_freq_val > 0) {
                freq_counts[old_freq_val]--;
                if (freq_counts[old_freq_val] == 0) {
                    num_distinct_non_zero_freqs--;
                }
            }

            freq[char_idx] = new_freq_val;

            freq_counts[new_freq_val]++;
            if (freq_counts[new_freq_val] == 1) {
                num_distinct_non_zero_freqs++;
            }

            if (num_distinct_non_zero_freqs == 1) {
                if (dp[j] != INT_MAX) {
                    if (1 + dp[j] < dp[i]) {
                        dp[i] = 1 + dp[j];
                    }
                }
            }
        }
    }

    int result = dp[n];
    free(dp);
    free(freq_counts);
    return result;
}