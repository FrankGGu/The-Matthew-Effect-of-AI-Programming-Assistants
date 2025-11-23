#include <string.h>
#include <stdlib.h>
#include <limits.h>

char * minWindow(char * s, char * t) {
    if (s == NULL || t == NULL || *s == '\0' || *t == '\0') {
        char* empty_str = (char*)malloc(sizeof(char));
        *empty_str = '\0';
        return empty_str;
    }

    int s_len = strlen(s);
    int t_len = strlen(t);

    if (t_len > s_len) {
        char* empty_str = (char*)malloc(sizeof(char));
        *empty_str = '\0';
        return empty_str;
    }

    int freq[128] = {0};
    for (int i = 0; i < t_len; i++) {
        freq[t[i]]++;
    }

    int left = 0;
    int right = 0;
    int matched_count = 0;
    int min_len = INT_MAX;
    int start_index = 0;

    while (right < s_len) {
        char r_char = s[right];
        if (freq[r_char] > 0) {
            matched_count++;
        }
        freq[r_char]--;

        while (matched_count == t_len) {
            int current_window_len = right - left + 1;
            if (current_window_len < min_len) {
                min_len = current_window_len;
                start_index = left;
            }

            char l_char = s[left];
            freq[l_char]++;
            if (freq[l_char] > 0) {
                matched_count--;
            }
            left++;
        }
        right++;
    }

    if (min_len == INT_MAX) {
        char* empty_str = (char*)malloc(sizeof(char));
        *empty_str = '\0';
        return empty_str;
    } else {
        char* result = (char*)malloc((min_len + 1) * sizeof(char));
        strncpy(result, s + start_index, min_len);
        result[min_len] = '\0';
        return result;
    }
}