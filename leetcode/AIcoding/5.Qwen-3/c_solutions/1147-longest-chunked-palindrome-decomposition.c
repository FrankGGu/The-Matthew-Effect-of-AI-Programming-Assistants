#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestDecomposition(char *s) {
    int n = strlen(s);
    int left = 0, right = n - 1;
    int count = 0;
    int start = 0;
    while (left <= right) {
        int len = 0;
        while (len < (right - left + 1) / 2) {
            if (strncmp(s + start, s + right - len, len + 1) == 0) {
                count++;
                start = right - len + 1;
                left = right - len + 1;
                break;
            }
            len++;
        }
        if (len >= (right - left + 1) / 2) {
            left++;
        } else {
            left = right - len + 1;
        }
    }
    return count;
}