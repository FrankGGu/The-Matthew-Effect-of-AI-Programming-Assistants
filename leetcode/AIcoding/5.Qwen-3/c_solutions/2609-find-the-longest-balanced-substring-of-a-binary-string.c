#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestBalancedSubstring(char* s) {
    int maxLen = 0;
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        int zeros = 0;
        int ones = 0;
        for (int j = i; j < n; j++) {
            if (s[j] == '0') zeros++;
            else ones++;
            if (zeros == ones) {
                maxLen = (j - i + 1) > maxLen ? (j - i + 1) : maxLen;
            }
        }
    }
    return maxLen;
}