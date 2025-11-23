#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* minWindow(char* s, char* t) {
    int len_s = strlen(s);
    int len_t = strlen(t);
    if (len_s < len_t || len_t == 0) return "";

    int required[128] = {0};
    int window[128] = {0};

    for (int i = 0; i < len_t; i++) {
        required[t[i]]++;
    }

    int formed = 0;
    int left = 0, right = 0;
    int min_len = INT_MAX;
    int result_left = 0, result_right = 0;

    while (right < len_s) {
        char c = s[right];
        window[c]++;
        if (required[c] > 0 && window[c] == required[c]) {
            formed++;
        }
        right++;

        while (formed == len_t) {
            if (right - left < min_len) {
                min_len = right - left;
                result_left = left;
                result_right = right;
            }

            char d = s[left];
            window[d]--;
            if (required[d] > 0 && window[d] < required[d]) {
                formed--;
            }
            left++;
        }
    }

    if (min_len == INT_MAX) return "";
    char* res = (char*)malloc((min_len + 1) * sizeof(char));
    strncpy(res, s + result_left, min_len);
    res[min_len] = '\0';
    return res;
}