#include <stdlib.h>
#include <string.h>
#include <limits.h>

char* minWindow(char* s, char* t) {
    int len_s = strlen(s);
    int len_t = strlen(t);

    if (len_t == 0) {
        char* res = (char*)malloc(1);
        res[0] = '\0';
        return res;
    }

    if (len_s == 0 || len_s < len_t) {
        char* res = (char*)malloc(1);
        res[0] = '\0';
        return res;
    }

    int target_map[128] = {0};
    for (int i = 0; i < len_t; i++) {
        target_map[t[i]]++;
    }

    int window_map[128] = {0};

    int window_start = 0;
    int min_len = INT_MAX;
    int min_start_idx = 0;
    int matched_chars = 0;

    for (int window_end = 0; window_end < len_s; window_end++) {
        char current_char = s[window_end];
        window_map[current_char]++;

        if (target_map[current_char] > 0 && window_map[current_char] <= target_map[current_char]) {
            matched_chars++;
        }

        while (matched_chars == len_t) {
            if (window_end - window_start + 1 < min_len) {
                min_len = window_end - window_start + 1;
                min_start_idx = window_start;
            }

            char char_to_remove = s[window_start];
            window_map[char_to_remove]--;

            if (target_map[char_to_remove] > 0 && window_map[char_to_remove] < target_map[char_to_remove]) {
                matched_chars--;
            }

            window_start++;
        }
    }

    if (min_len == INT_MAX) {
        char* res = (char*)malloc(1);
        res[0] = '\0';
        return res;
    } else {
        char* res = (char*)malloc(min_len + 1);
        strncpy(res, s + min_start_idx, min_len);
        res[min_len] = '\0';
        return res;
    }
}