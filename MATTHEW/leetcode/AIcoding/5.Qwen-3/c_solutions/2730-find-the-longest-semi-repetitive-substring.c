#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSemiRepetitiveSubstring(char *s) {
    int n = strlen(s);
    int maxLen = 1;
    for (int i = 0; i < n; i++) {
        int count = 0;
        for (int j = i + 1; j < n; j++) {
            if (s[j] == s[j - 1]) {
                count++;
            }
            if (count <= 1) {
                maxLen = fmax(maxLen, j - i + 1);
            } else {
                break;
            }
        }
    }
    return maxLen;
}