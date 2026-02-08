#include <string.h>

int findAnagrams(char * s, char * p) {
    int n = strlen(s);
    int m = strlen(p);

    if (m == 0) {
        return 0;
    }
    if (n < m) {
        return 0;
    }

    int p_freq[26] = {0};
    int s_freq[26] = {0};

    for (int i = 0; i < m; i++) {
        p_freq[p[i] - 'a']++;
    }

    int match_count = 0;
    for (int i = 0; i < m; i++) {
        s_freq[s[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if (p_freq[i] == s_freq[i]) {
            match_count++;
        }
    }

    int ans = 0;
    if (match_count == 26) {
        ans++;
    }

    for (int i = m; i < n; i++) {
        int char_left_idx = s[i - m] - 'a';
        int char_right_idx = s[i] - 'a';

        if (s_freq[char_left_idx] == p_freq[char_left_idx]) {
            match_count--;
        }
        s_freq[char_left_idx]--;
        if (s_freq[char_left_idx] == p_freq[char_left_idx]) {
            match_count++;
        }

        if (s_freq[char_right_idx] == p_freq[char_right_idx]) {
            match_count--;
        }
        s_freq[char_right_idx]++;
        if (s_freq[char_right_idx] == p_freq[char_right_idx]) {
            match_count++;
        }

        if (match_count == 26) {
            ans++;
        }
    }

    return ans;
}