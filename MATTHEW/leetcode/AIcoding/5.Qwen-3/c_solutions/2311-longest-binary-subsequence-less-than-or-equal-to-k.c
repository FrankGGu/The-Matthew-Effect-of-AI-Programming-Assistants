#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestBinarySubsequenceLessThanK(char *s, int k) {
    int n = strlen(s);
    int count = 0;
    int len = 0;
    int64_t val = 0;

    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == '1') {
            if (len > 0) {
                val = (val << 1) | 1;
            } else {
                val = 1;
            }
            if (val > k) {
                break;
            }
            count++;
        }
        len++;
    }

    return count;
}