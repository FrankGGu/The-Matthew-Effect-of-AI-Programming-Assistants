#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int longestSubsequenceRepeatedK(char *s, int k) {
    int n = strlen(s);
    int maxLen = 0;

    for (int len = 1; len <= n; len++) {
        int count[26] = {0};
        for (int i = 0; i < n; i++) {
            if (i + len <= n) {
                char *sub = strndup(s + i, len);
                int found = 0;
                for (int j = 0; j < i; j++) {
                    if (strncmp(sub, s + j, len) == 0) {
                        found = 1;
                        break;
                    }
                }
                if (found) {
                    count[len - 1]++;
                }
                free(sub);
            }
        }
        if (count[len - 1] >= k) {
            maxLen = len;
        }
    }
    return maxLen;
}