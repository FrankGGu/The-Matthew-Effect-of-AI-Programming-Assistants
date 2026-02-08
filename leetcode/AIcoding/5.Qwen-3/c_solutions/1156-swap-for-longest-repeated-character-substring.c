#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxRepOptI(char* text) {
    int n = strlen(text);
    int* count = (int*)malloc(26 * sizeof(int));
    memset(count, 0, 26 * sizeof(int));
    for (int i = 0; i < n; i++) {
        count[text[i] - 'a']++;
    }

    int max_len = 0;
    int i = 0;
    while (i < n) {
        char c = text[i];
        int j = i;
        while (j < n && text[j] == c) j++;
        int len = j - i;
        if (len > 1) {
            int total = len;
            if (count[c - 'a'] > len) total++;
            max_len = (max_len > total) ? max_len : total;
        }
        i = j;
    }

    i = 0;
    while (i < n - 1) {
        if (text[i] != text[i + 1]) {
            int left = i - 1;
            int right = i + 2;
            while (left >= 0 && text[left] == text[i + 1]) left--;
            while (right < n && text[right] == text[i]) right++;
            int len = (i - left - 1) + (right - i - 1) + 1;
            if (count[text[i] - 'a'] > (i - left - 1) + 1) len++;
            if (count[text[i + 1] - 'a'] > (right - i - 1) + 1) len++;
            max_len = (max_len > len) ? max_len : len;
        }
        i++;
    }

    free(count);
    return max_len;
}