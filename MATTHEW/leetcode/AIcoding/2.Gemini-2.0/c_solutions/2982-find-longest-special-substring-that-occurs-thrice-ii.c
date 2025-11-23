#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countOccurrences(const char *s, int n, char c, int len) {
    int count = 0;
    for (int i = 0; i <= n - len; ++i) {
        int j;
        for (j = 0; j < len; ++j) {
            if (s[i + j] != c) {
                break;
            }
        }
        if (j == len) {
            count++;
            i += len - 1;
        }
    }
    return count;
}

int longestSpecialSubstring(char *s) {
    int n = strlen(s);
    int maxLength = 0;

    for (char c = 'a'; c <= 'z'; ++c) {
        int low = 1;
        int high = n;
        int result = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (countOccurrences(s, n, c, mid) >= 3) {
                result = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        maxLength = (maxLength > result) ? maxLength : result;
    }

    return maxLength;
}