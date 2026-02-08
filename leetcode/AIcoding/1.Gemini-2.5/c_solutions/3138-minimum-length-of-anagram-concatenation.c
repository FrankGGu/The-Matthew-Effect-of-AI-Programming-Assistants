#include <string.h>
#include <stdbool.h>

void calculate_freq(const char *s, int start, int len, int *freq) {
    for (int i = 0; i < 26; ++i) {
        freq[i] = 0;
    }
    for (int i = 0; i < len; ++i) {
        freq[s[start + i] - 'a']++;
    }
}

bool compare_freq(const int *freq1, const int *freq2) {
    for (int i = 0; i < 26; ++i) {
        if (freq1[i] != freq2[i]) {
            return false;
        }
    }
    return true;
}

int minLengthAfterAnagramConcatenation(char *s) {
    int n = strlen(s);

    for (int k = 1; k <= n; ++k) {
        if (n % k == 0) {
            int freq_first_block[26];
            calculate_freq(s, 0, k, freq_first_block);

            bool all_blocks_anagrams = true;
            for (int i = k; i < n; i += k) {
                int freq_current_block[26];
                calculate_freq(s, i, k, freq_current_block);

                if (!compare_freq(freq_first_block, freq_current_block)) {
                    all_blocks_anagrams = false;
                    break;
                }
            }

            if (all_blocks_anagrams) {
                return k;
            }
        }
    }
    return n;
}