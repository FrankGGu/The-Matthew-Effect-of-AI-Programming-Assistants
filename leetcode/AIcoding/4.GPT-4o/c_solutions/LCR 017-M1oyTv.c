#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define CHAR_COUNT 128

char* minWindow(char* s, char* t) {
    int s_len = strlen(s), t_len = strlen(t);
    if (s_len < t_len) return "";

    int t_freq[CHAR_COUNT] = {0}, s_freq[CHAR_COUNT] = {0};
    for (int i = 0; i < t_len; i++) {
        t_freq[t[i]]++;
    }

    int left = 0, right = 0, min_len = INT_MAX, min_left = 0, count = 0;

    while (right < s_len) {
        char r_char = s[right];
        if (t_freq[r_char] > 0) {
            s_freq[r_char]++;
            if (s_freq[r_char] <= t_freq[r_char]) {
                count++;
            }
        }
        right++;

        while (count == t_len) {
            if (right - left < min_len) {
                min_len = right - left;
                min_left = left;
            }
            char l_char = s[left];
            if (t_freq[l_char] > 0) {
                s_freq[l_char]--;
                if (s_freq[l_char] < t_freq[l_char]) {
                    count--;
                }
            }
            left++;
        }
    }

    if (min_len == INT_MAX) return "";

    char* result = (char*)malloc((min_len + 1) * sizeof(char));
    strncpy(result, s + min_left, min_len);
    result[min_len] = '\0';
    return result;
}