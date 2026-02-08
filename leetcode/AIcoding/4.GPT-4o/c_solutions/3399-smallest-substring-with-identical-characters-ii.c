#include <stdio.h>
#include <string.h>

int smallestSubstring(char *s) {
    int n = strlen(s);
    int min_length = n + 1;
    int count[256] = {0};
    int unique_count = 0;

    for (int i = 0; i < n; i++) {
        if (count[s[i]] == 0) unique_count++;
        count[s[i]]++;
    }

    int left = 0, right = 0;
    int formed = 0;
    int window_count[256] = {0};

    while (right < n) {
        char right_char = s[right];
        window_count[right_char]++;
        if (window_count[right_char] == count[right_char]) {
            formed++;
        }

        while (left <= right && formed == unique_count) {
            char left_char = s[left];

            if (right - left + 1 < min_length) {
                min_length = right - left + 1;
            }

            window_count[left_char]--;
            if (window_count[left_char] < count[left_char]) {
                formed--;
            }
            left++;
        }
        right++;
    }

    return min_length == n + 1 ? 0 : min_length;
}