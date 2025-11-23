#include <string.h>
#include <stdlib.h>

int countSubstrings(char *s, int k) {
    int n = strlen(s);
    int count = 0;
    int freq[26];

    for (int i = 0; i < n; i++) {
        memset(freq, 0, sizeof(freq));
        int distinct_chars = 0;
        int k_freq_chars = 0;

        for (int j = i; j < n; j++) {
            int char_idx = s[j] - 'a';

            if (freq[char_idx] == 0) {
                distinct_chars++;
            }
            freq[char_idx]++;

            if (freq[char_idx] == k) {
                k_freq_chars++;
            } else if (freq[char_idx] == k + 1) {
                k_freq_chars--;
            }

            if (distinct_chars == k_freq_chars) {
                count++;
            }
        }
    }
    return count;
}