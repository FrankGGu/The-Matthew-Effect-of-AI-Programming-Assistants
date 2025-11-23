#include <stdlib.h>
#include <string.h>

int (*next_char_idx)[26];

int check_optimized(const char* s, int s_len, const char* t, int t_len, int k) {
    if (t_len == 0) return 1;

    int current_s_idx = 0;
    for (int i = 0; i < k; ++i) {
        int temp_s_idx = current_s_idx;
        for (int j = 0; j < t_len; ++j) {
            int char_code = t[j] - 'a';
            if (temp_s_idx >= s_len) return 0;

            int next_occurrence = next_char_idx[temp_s_idx][char_code];

            if (next_occurrence == -1) return 0;

            temp_s_idx = next_occurrence + 1;
        }
        current_s_idx = temp_s_idx;
    }
    return 1;
}

int can_form(int target_len, const char* s, int s_len, int k) {
    if (target_len == 0) return 1;

    char current_t_buffer[target_len + 1];
    current_t_buffer[target_len] = '\0';

    for (int i = 0; i < target_len; ++i) {
        int found_char_for_pos = 0;
        for (char c_val = 'a'; c_val <= 'z'; ++c_val) {
            current_t_buffer[i] = c_val;
            if (check_optimized(s, s_len, current_t_buffer, i + 1, k)) {
                found_char_for_pos = 1;
                break;
            }
        }
        if (!found_char_for_pos) {
            return 0;
        }
    }
    return 1;
}

char* longestSubsequenceRepeatedK(char* s, int k) {
    int s_len = strlen(s);

    next_char_idx = (int (*)[26])malloc((s_len + 1) * sizeof(*next_char_idx));
    if (next_char_idx == NULL) return strdup("");

    for (int c = 0; c < 26; ++c) {
        next_char_idx[s_len][c] = -1;
    }
    for (int i = s_len - 1; i >= 0; --i) {
        for (int c = 0; c < 26; ++c) {
            next_char_idx[i][c] = next_char_idx[i+1][c];
        }
        next_char_idx[i][s[i]-'a'] = i;
    }

    int char_counts[26] = {0};
    for (int i = 0; i < s_len; ++i) {
        char_counts[s[i]-'a']++;
    }
    int max_possible_len_t = 0;
    for (int i = 0; i < 26; ++i) {
        max_possible_len_t += char_counts[i] / k;
    }

    int low = 0, high = max_possible_len_t;
    int ans_len = 0;

    while (low <= high) {
        int mid_len = low + (high - low) / 2;
        if (can_form(mid_len, s, s_len, k)) {
            ans_len = mid_len;
            low = mid_len + 1;
        } else {
            high = mid_len - 1;
        }
    }

    if (ans_len == 0) {
        free(next_char_idx);
        return strdup("");
    }

    char* final_t = (char*)malloc((ans_len + 1) * sizeof(char));
    if (final_t == NULL) {
        free(next_char_idx);
        return strdup("");
    }
    final_t[ans_len] = '\0';

    for (int i = 0; i < ans_len; ++i) {
        for (char c_val = 'z'; c_val >= 'a'; --c_val) {
            final_t[i] = c_val;
            if (check_optimized(s, s_len, final_t, i + 1, k)) {
                break;
            }
        }
    }

    free(next_char_idx);
    return final_t;
}