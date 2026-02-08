#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSemiRepetitiveSubstring(char * s) {
    int n = 0;
    while (s[n] != '\0') {
        n++;
    }
    int maxLen = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int count = 0;
            for (int k = i; k < j; k++) {
                if (s[k] == s[k + 1]) {
                    count++;
                }
            }
            if (count <= 1) {
                if (j - i + 1 > maxLen) {
                    maxLen = j - i + 1;
                }
            }
        }
    }
    return maxLen;
}