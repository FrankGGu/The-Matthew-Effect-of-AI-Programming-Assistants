#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef unsigned long long ull;

int compare(char *s, int l, int r, int len) {
    for (int i = 0; i < len; i++) {
        if (s[l + i] != s[r + i]) return 0;
    }
    return 1;
}

int search(char *s, int n, int *ans) {
    int low = 0, high = n - 1;
    int max_len = 0;
    while (low <= high) {
        int mid = (low + high) / 2;
        int found = 0;
        for (int i = 0; i + mid < n; i++) {
            if (compare(s, i, i + 1, mid)) {
                found = 1;
                *ans = i;
                break;
            }
        }
        if (found) {
            max_len = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return max_len;
}

char* longestDupSubstring(char* s) {
    int n = strlen(s);
    int ans = 0;
    search(s, n, &ans);
    char *res = (char *)malloc((n + 1) * sizeof(char));
    strncpy(res, s + ans, n - ans);
    res[n - ans] = '\0';
    return res;
}