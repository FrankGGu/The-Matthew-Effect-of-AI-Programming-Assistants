#include <stdlib.h>
#include <string.h>
#include <limits.h>

#define MAX_CHAR 128

char* minWindow(char* s, char* t) {
    int s_len = strlen(s);
    int t_len = strlen(t);

    if (s_len == 0 || t_len == 0 || s_len < t_len) {
        return "";
    }

    int t_freq[MAX_CHAR] = {0};
    int window_freq[MAX_CHAR] = {0};

    for (int i = 0; i < t_len; i++) {
        t_freq[t[i]]++;
    }

    int required = 0;
    for (int i = 0; i < MAX_CHAR; i++) {
        if (t_freq[i] > 0) {
            required++;
        }
    }

    int left = 0, right = 0;
    int formed = 0;
    int min_len = INT_MAX;
    int start_idx = 0;

    while (right < s_len) {
        char c = s[right];
        window_freq[c]++;

        if (t_freq[c] > 0 && window_freq[c] == t_freq[c]) {
            formed++;
        }

        while (left <= right && formed == required) {
            c = s[left];

            if (right - left + 1 < min_len) {
                min_len = right - left + 1;
                start_idx = left;
            }

            window_freq[c]--;
            if (t_freq[c] > 0 && window_freq[c] < t_freq[c]) {
                formed--;
            }

            left++;
        }

        right++;
    }

    if (min_len == INT_MAX) {
        return "";
    }

    char* result = (char*)malloc((min_len + 1) * sizeof(char));
    strncpy(result, s + start_idx, min_len);
    result[min_len] = '\0';

    return result;
}